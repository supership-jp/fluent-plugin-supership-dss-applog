require 'fluent/filter'
require 'json'

module Fluent
  class SupershipDssApplogFilter < Filter
    Fluent::Plugin.register_filter('applog', self)

    config_param :prefix_name, :string
    config_param :service_name, :string
    config_param :log_type, :string
    config_param :timestamp_key, :string, default: nil

    def configure(conf)
      super
    end

    def filter(tag, time, record)
      "#{@prefix_name}.#{@service_name}.#{@log_type}\t#{timestamp(time, record)}\t#{record.to_json}\n"
    end

    def timestamp(time, record)
      @timestamp_key.nil? ? time.sec : record[@timestamp_key]
    end
  end
end
