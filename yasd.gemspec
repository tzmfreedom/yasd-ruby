# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yasd/version'

Gem::Specification.new do |spec|
  spec.name          = 'yasd'
  spec.version       = Yasd::VERSION
  spec.authors       = ['tzmfreedom']
  spec.email         = ['makoto_tajitsu@hotmail.co.jp']

  spec.summary       = 'Yet Another Salesforce Detaloader'
  spec.description   = 'Yet Another Salesforce Dataloader'
  spec.homepage      = 'https://github.com/tzmfreedom/yasd'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'soapforce', '~> 0.7.0'
  spec.add_runtime_dependency 'thor', '~> 0.20.0'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'onkcop'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
end
