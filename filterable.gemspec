# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filterable/version'

Gem::Specification.new do |spec|
  spec.name          = "filterable"
  spec.version       = Filterable::VERSION
  spec.authors       = ["Venkat Dinavahi"]
  spec.email         = ["venkat@letsfunnel.com"]
  spec.description   = %q{Filterable provides a very simple collection that you can extend to cleanly create filterable objects.}
  spec.summary       = %q{Filterable provides a very simple collection that you can extend to cleanly create filterable objects.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
end
