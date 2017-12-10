# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = "conchiterz"
  spec.version       = Conchiterz::VERSION
  spec.authors       = ["Clement Morisset"]
  spec.email         = ["morissetcl87@gmail.com"]

  spec.homepage      = "https://github.com/morissetcl/conchiterz"
  spec.summary       = "Conchiterz allow you to feminize french word/sentence"
  spec.license       = "MIT"
  spec.add_development_dependency "rspec", "~> 3.2"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
end
