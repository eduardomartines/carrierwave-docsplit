# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "carrierwave/pdf2thumbs/version"

Gem::Specification.new do |spec|
  spec.name          = "carrierwave-pdf2thumbs"
  spec.version       = Carrierwave::Pdf2thumbs::VERSION
  spec.authors       = ["Eduardo Martines"]
  spec.email         = ["martines.eduardo@gmail.com"]
  spec.summary       = %q{Carrierwave extension that generates thumbnails of pdf pages}
  spec.description   = %q{This extension uses Docsplit to get the job done and it"s compatible with AWS S3 using Carrierwave + Fog}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rspec", ">= 2.10.0"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "carrierwave"
  spec.add_runtime_dependency "docsplit"
end
