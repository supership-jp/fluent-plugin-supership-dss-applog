require 'helper'

class SupershipDssApplogFilterTest < Test::Unit::TestCase

  RECORD_TIME = Time.now.to_i

  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
    prefix_name extlog
    service_name my
    log_type test
    timestamp_key timestamp
  ]

  def create_driver(conf = CONFIG, tag = 'my.test')
    Fluent::Test::FilterTestDriver.new(Fluent::SupershipDssApplogFilter, tag).configure(conf)
  end

  def filter_assert(filter_record, original_record)
    assert_equal filter_record[1], RECORD_TIME
    assert_equal filter_record[2], "extlog.my.test\t#{RECORD_TIME}\t#{original_record.to_json}\n"
  end

  def test_filter_default
    d = create_driver

    # 2 colomn
    record1 = {
      'message' => 'message test',
      'timestamp' => RECORD_TIME
    }
    d.emit(record1)

    # 3 colomn
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

  def test_filter_nothing_timestamp_key
    d = create_driver(%[
      prefix_name extlog
      service_name my
      log_type test
    ])

    record = {
      'message' => 'message test'
    }
    d.emit(record)

    d.run
    assert_match(/^.*\..*\..*\t[0-9]{10}\t.*/, d.filtered_as_array[0][2])
  end

  def test_filter_fail
    # 'Nothing prefix_name'
    begin
      create_driver(%[
        log_type test
        timestamp_key timestamp
      ])
    rescue Exception => e
      assert_equal e.message, "'prefix_name' parameter is required"
    end

    # 'Nothing service_name'
    begin
      create_driver(%[
        prefix_name extlog
        log_type test
        timestamp_key timestamp
      ])
    rescue Exception => e
      assert_equal e.message, "'service_name' parameter is required"
    end

    # 'Nothing log_type'
    begin
      create_driver(%[
        prefix_name extlog
        service_name my
        timestamp_key timestamp
      ])
    rescue Exception => e
      assert_equal e.message, "'log_type' parameter is required"
    end
  end
end
