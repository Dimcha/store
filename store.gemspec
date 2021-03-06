# -*- encoding: utf-8 -*-

require File.expand_path('../lib/store/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "store"
  gem.version       = Store::VERSION
  gem.summary       = 'Store with discounts'
  gem.description   = 'Task made to CGTrader'
  gem.license       = "MIT"
  gem.authors       = ["Dimcha"]
  gem.email         = "avedenij@yahoo.com"
  gem.homepage      = "https://rubygems.org/gems/store"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rdoc', '~> 3.0'
  gem.add_development_dependency 'rspec', '~> 3.0.0'
  gem.add_development_dependency 'json', '~> 1.8.1'
  gem.add_development_dependency 'hash-to-ostruct', '~> 0.0.1'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
end
