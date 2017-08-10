# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "chapex/version"

Gem::Specification.new do |spec|
  spec.name          = "chapex"
  spec.version       = Chapex::VERSION
  spec.authors       = ["gk0909c"]
  spec.email         = ["gk0909c@gmail.com"]

  spec.summary       = 'check apex syntax for ci'
  spec.description   = 'check apex syntax for ci'
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").push('lib/chapex/apex.rb').reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ast", "~> 2.3"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.1"

  spec.add_development_dependency 'racc', '= 1.4.14'
  spec.add_development_dependency 'yard', '~> 0.9.9'
  spec.add_development_dependency 'pry', '~> 0.10.4'
end
