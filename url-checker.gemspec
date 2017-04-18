# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'url_checker/version'

Gem::Specification.new do |s|
  s.name = 'url-checker'
  s.version = UrlChecker::VERSION
  s.summary = 'Check URLs from a CSV'
  s.description = 'A Ruby CLI for checking a list of URLs from a CSV file.'
  s.authors = ['Kevin McCormack']
  s.email = 'HarlemSquirrel@gmail.com'
  s.files = Dir['bin/*'] + Dir['config/*.rb'] + Dir['lib/**/*'] + Dir['README.md']
  s.homepage    = 'https://github.com/HarlemSquirrel/url-checker'
  s.license     = 'MIT'
  s.executables << 'checkurls'

  s.required_ruby_version = '>= 2.4.0'
  s.add_runtime_dependency 'addressable', '~> 2.5.1'
  s.add_runtime_dependency 'colorize', '~> 0.8'
end
