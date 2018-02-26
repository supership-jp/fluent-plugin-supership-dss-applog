require 'fluent/filter'
require 'json'

module Fluent
  class SupershipDssApplogFilter < Filter
    Fluent::Plugin.register_filter('supership-dss-applog', self)

    def configure(conf)
      super
      @prefix_name = conf['prefix_name']
      @timestamp_key = conf['timestamp_key']
    end

    def filter(tag, time, record)
      "#{@prefix_name}.#{tag}\t#{record[@timestamp_key]}\t#{record.to_json}\n"
    end
  end
end

