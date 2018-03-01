# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluent/plugin/supership-dss-applog/version'

Gem::Specification.new do |gem|
  gem.name          = "fluent-plugin-supership-dss-applog"
  gem.version       = Fluent::SupershipDssApplog::VERSION
  gem.authors       = ["a4t"]
  gem.email         = ["shigure.onishi@supership.jp"]

  gem.summary       = %q{DSS common ETL Service connect Input and Outout Plugin.}
  gem.description   = %q{This plugin is DSS common ETL Service connect plugin.}
  gem.homepage      = "https://github.com/supership-jp/fluent-plugin-supership-dss-applog"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split("\n")
  gem.bindir        = "bin"
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.12"
  gem.add_development_dependency "rake", "~> 10.0"
  gem.add_development_dependency "test-unit", "~> 3.2"

  gem.add_runtime_dependency "fluentd", "~> 0"
end
