# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'es/version'

Gem::Specification.new do |gem|
  gem.name          = "es"
  gem.version       = ES::VERSION
  gem.authors       = ['Jan Suchal']
  gem.email         = ['johno@jsmf.net']
  gem.description   = 'Simple wrapper for elasticsearch'
  gem.summary       = 'Simple wrapper for elasticsearch.'
  gem.homepage      = 'http://github.com/minio-sk/es'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
end
