# encoding: UTF-8
require File.expand_path('../lib/armory/version', __FILE__)

Gem::Specification.new do |s|
  s.name               = 'armory'
  s.homepage           = 'http://github.com/gaffneyc/armory'
  s.summary            = 'Library for downloading and parsing the wow armory'
  s.require_path       = 'lib'
  s.authors            = ['Chris Gaffney', 'Jason Roelofs']
  s.email              = ['gaffneyc@gmail.com', 'jameskilton@gmail.com']
  s.version            = Armory::VERSION
  s.platform           = Gem::Platform::RUBY
  s.files              = Dir.glob("{lib,spec}/**/*") + %w[LICENSE README.rdoc]

  s.add_dependency 'nokogiri', '~> 1.4.3'
  s.add_dependency 'typhoeus', '~> 0.2.0'

  s.add_development_dependency 'rspec',  '~> 2.1.0'
  s.add_development_dependency 'mocha',  '~> 0.9.9'
end
