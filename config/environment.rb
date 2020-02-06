# frozen_string_literal: true

require 'benchmark'
require 'csv'
require 'net/http'
require 'rubygems'

require 'bundler/setup'

require 'addressable/uri'
require 'colorize'
require 'openssl'

require_relative '../lib/url_checker'
require_relative '../lib/url_checker/cli'
require_relative '../lib/url_checker/rescued_response'
require_relative '../lib/url_checker/single_checker'
require_relative '../lib/url_checker/version'
