require 'helper'

class SupershipDssApplogFilterTest < Test::Unit::TestCase

  RECORD_TIME = Time.now.to_i
  DEFAULT_TAG = 'my.test'

  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
    prefix_name extlog
    timestamp_key timestamp
  ]

  def create_driver(conf = CONFIG, tag = DEFAULT_TAG)
    Fluent::Test::FilterTestDriver.new(Fluent::SupershipDssApplogFilter, tag).configure(conf)
  end

  def filter_assert(filter_record, original_record)
    assert_equal filter_record[0], 'my.test'
    assert_equal filter_record[1], RECORD_TIME
    assert_equal filter_record[2], "extlog.#{DEFAULT_TAG}\t#{RECORD_TIME}\t#{original_record.to_json}\n"
  end

  def test_filter
    d = create_driver

    record1 = {
      'message' => 'message test',
      'timestamp' => RECORD_TIME
    }
    d.emit(record1)

    record2 = {
      'message' => 'message test',
      'date' => Time.now,
      'timestamp' => RECORD_TIME
    }
    d.emit(record2)

    d.run
    filter_assert(d.filtered_as_array[0], record1)
    filter_assert(d.filtered_as_array[1], record2)
  end

  def test_filter_fail
    d = create_driver(CONFIG, 'my.fail.test')
    record = {
      'message' => 'message test',
      'timestamp' => RECORD_TIME
    }
    d.emit(record)

    d.run
    assert_not_equal(d.filtered_as_array[0][0], DEFAULT_TAG)
    assert_equal(d.filtered_as_array[0][1], RECORD_TIME)
    assert_not_equal(d.filtered_as_array[0][2], "extlog.#{DEFAULT_TAG}\t#{RECORD_TIME}\t#{record.to_json}\n")
  end
end
