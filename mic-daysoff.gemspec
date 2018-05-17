# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mic/daysoff/version'

Gem::Specification.new do |spec|
  spec.name          = "mic-daysoff"
  spec.version       = Mic::Daysoff::VERSION
  spec.authors       = ["Jean-Jacques MOIROUX"]
  spec.email         = ["jeanjacques.moiroux@makeitcheaper.com"]

  spec.summary       = "Provide days off"
  spec.description   = "Rails gem get days off, holidays from a remote file on S3 for example"
  spec.homepage      = "http://github.com/makeitcheaper/mic-days-off"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "timecop"
end
