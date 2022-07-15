# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jekyll-url-metadata/version"
require "date"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-url-metadata"
  spec.version       = Jekyll::URLMetadata::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.required_ruby_version = ">= 2.0.0"  # Same as Jekyll
  spec.date          = DateTime.now.strftime("%Y-%m-%d")
  spec.authors       = ["Gourav Khunger"]
  spec.email         = ["gouravkhunger18@gmail.com"]
  spec.homepage      = "https://github.com/gouravkhunger/jekyll-url-metadata"
  spec.license       = "MIT"

  spec.summary       = "Extract all kind of meta data from a url string"
  spec.description   = "A plugin to expose meta data information from the head tag of a webapge to liquid variables just from its url string."

  spec.files          = Dir["*.gemspec", "Gemfile", "lib/**/*"]
  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_runtime_dependency "jekyll", ">= 3.0.0"
  spec.add_runtime_dependency "nokogiri", ">= 1.10.0"

end
