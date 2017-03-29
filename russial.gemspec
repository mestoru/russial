# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "russial/version"

Gem::Specification.new do |spec|
  spec.name          = "russial"
  spec.version       = Russial::VERSION
  spec.authors       = ["Mesto.ru"]
  spec.email         = ["jt@mesto.ru"]

  spec.summary       = "Plain interface for word declension."
  spec.description   = "Get a simple way for case inflection."
  spec.homepage      = "https://github.com/mestoru/russial"
  spec.license       = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.2.0"

  spec.add_dependency "backport_dig", "0.0.2" if RUBY_VERSION < "2.3.0"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "i18n", "~> 0.7.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10.4"
  spec.add_development_dependency "simplecov", "~> 0.12.0"
end
