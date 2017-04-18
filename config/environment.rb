# frozen_string_literal: true

require 'addressable/uri'
require 'benchmark'
require 'colorize'
require 'csv'
require 'net/http'

require_relative '../lib/url_checker'
require_relative '../lib/url_checker/cli'
require_relative '../lib/url_checker/rescued_response'
require_relative '../lib/url_checker/single_checker'
require_relative '../lib/url_checker/version'
