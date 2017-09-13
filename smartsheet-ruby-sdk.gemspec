# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smartsheet/version'

Gem::Specification.new do |spec|
  spec.name          = 'smartsheet-ruby-sdk'
  spec.version       = Smartsheet::VERSION
  spec.author        = 'Smartsheet'

  spec.summary       = 'An SDK to simplify connecting to the Smartsheet API from Ruby applications.'
  spec.description   = <<-EOF
    This is an SDK to simplify connecting to the [Smartsheet API](http://www.smartsheet.com/developers/api-documentation) from Ruby applications.
    *Please note that this SDK is beta and may change significantly in the future.*
  EOF
  spec.homepage      = 'http://smartsheet.com/developers'
  spec.license       = 'Apache-2.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  unless spec.respond_to?(:metadata)
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(/^(test|spec|features)/)
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 0.13.1'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rubocop', '~> 0.49.1'
  spec.add_development_dependency 'reek', '~> 4.7.2'
  spec.add_development_dependency 'rubycritic', '~> 3.2.3'
end
