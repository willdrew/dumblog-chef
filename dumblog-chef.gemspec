# encoding: UTF-8

$:.push File.expand_path('../lib', __FILE__)
require File.expand_path('../lib/dumblog-chef/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'dumblog-chef'
  gem.version       = DumblogChef::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ['Will Drew']
  gem.email         = ['willdrew@gmail.com']
  gem.summary       = %q{}
  gem.description   = %q{}
  gem.homepage      = 'https://github.com/willdrew/dumblog-chef'

  gem.required_rubygems_version = '>= 1.3.6'
  gem.required_ruby_version = ::Gem::Requirement.new('>= 1.9.3')

  gem.add_dependency('chef', '>= 11.12.4')
  gem.add_dependency('aws-sdk', '>= 1.38.0')
  gem.add_development_dependency('rake', '~> 10.4')
  gem.add_development_dependency('bundler', '~> 1.7')
  gem.add_development_dependency('pry', '~> 0.10')
  gem.add_development_dependency('mocha', '~> 1.1')
  gem.add_development_dependency('shoulda-context', '~> 1.2')

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.require_paths = %w(lib)
end
