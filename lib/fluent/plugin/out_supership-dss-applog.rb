require 'json'

module Fluent
  class SupershipDssApplogOutput < Output
    Fluent::Plugin.register_output('supership-dss-applog', self)

    config_param :new_tag, :string
    config_param :prefix_name, :string
    config_param :service_name, :string
    config_param :log_type, :string
    config_param :timestamp_key, :string, default: nil
    config_param :add_time, :bool, default: false
    config_param :add_time_key, :string, default: nil

    def configure(conf)
      super
    end

    def emit(tag, es, chain)
      chain.next
      es.each {|time, record|
        record['time'] = record['ts'] if @add_time
        new_record = "#{@prefix_name}.#{@service_name}.#{@log_type}\t#{timestamp(time, record)}\t#{record.to_json}\n"
        router.emit(@new_tag, time, new_record)
      }
    end

    def timestamp(time, record)
      @timestamp_key.nil? ? time : record[@timestamp_key]
    end
  end
end
