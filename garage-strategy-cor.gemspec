# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'garage/strategy/cor/version'

Gem::Specification.new do |spec|
  spec.name          = "garage-strategy-cor"
  spec.version       = Garage::Strategy::Cor::VERSION
  spec.authors       = ["wata"]
  spec.email         = ["wata-gh"]

  spec.summary       = %q{Garage strategy Chain of Responsibility.}
  spec.description   = %q{Garage strategy Chain of Responsibility pattern.}
  spec.homepage      = "https://github.com/wata-gh/garage-strategy-cor"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "the_garage"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end
