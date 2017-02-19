# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name = 'url-checker'
  s.version = '1.0'
  s.summary = 'A Ruby CLI for checking a list of URLs from a CSV file'
  s.description = 'A Ruby CLI for checking a list of URLs from a CSV file'
  s.authors = ['Kevin McCormack']
  s.email = 'HarlemSquirrel@gmail.com'
  s.files = `git ls-files -- lib/*`.split("\n")
  s.homepage    = 'https://github.com/HarlemSquirrel/url-checker'
  s.license     = 'MIT'
  s.executables << 'checkurls'

  s.required_ruby_version = '>= 2.4.0'
  s.add_runtime_dependency 'colorize', '~> 0.8'
end
