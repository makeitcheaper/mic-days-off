# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mic/daysoff/version'

Gem::Specification.new do |spec|
  spec.name          = "mic-daysoff"
  spec.version       = Mic::Daysoff::VERSION
  spec.authors       = ["Jean-Jacques MOIROUX", "Boaz Yehezkel"]
  spec.email         = ["jeanjacques.moiroux@makeitcheaper.com", "boaz.yehezkel@makeitcheaper.com"]
  spec.summary       = "Provide days off"
  spec.description   = "Rails gem get days off, holidays from a remote file on S3 for example"
  spec.homepage      = "http://github.com/makeitcheaper/mic-days-off"
  spec.files         = [ "lib/mic/daysoff/daysoff.rb", "lib/daysoff.rb" ]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "timecop"
end
