# Fluent::Plugin::SupershipDssApplog

This Plugin is dss applog format converter

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fluent-plugin-supership-dss-applog'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-supership-dss-applog

## Usage

This Plugins output text format.

```
<prefix_name>.<service_name>.<log_type>¥t<timestamp>¥t<record>
```

### Filter Plugin

- timestamp_key
  - Use record key. (default: record time)

```
<filter test.test>
  @type supership-dss-applog
  prefix_name example (require)
  service_name abc (require)
  log_type log (require)
  timestamp_key timestamp_key (option)
</filter>
```

### Output Plugin

- timestamp_key
  - Use record key. (default: record time)

- add_time
  - add time key.

- add_time_key
  - add time key value.

```
<match test.test>
  @type supership-dss-applog
  new_tag example (require)
  prefix_name example (require)
  service_name abc (require)
  log_type log (require)
  timestamp_key timestamp_key (option)
  add_time true (option)
  add_time_key ts (option)
</match>
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Local Test

```
$ gem install geminabox
$ docker-compose build rubygems-sever
$ docker-compose up -d rubygems-sever
```

loop

```
$ gem build ./fluent-plugin-supership-dss-applog.gemspec
$ gem inabox -o --host http://localhost:9292 fluent-plugin-supership-dss-applog-0.0.10.gem
$ docker-compose stop fluentd
$ docker-compose rm -f fluentd
$ docker-compose build fluentd
$ docker-compose up -d fluentd
$ docker-compose logs -f
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fluent-plugin-supership-dss-applog. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

1. Fork it ( http://github.com/supership-jp/fluent-plugin-supership-dss-applog )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

