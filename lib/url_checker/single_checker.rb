# frozen_string_literal: true

module UrlChecker
  # Checks a single URL and returns the result
  class SingleChecker
    INVALID_URI_MSG = 'must begin with http and contain only valid characters'
    OPEN_TIMEOUT = 1 # Number of seconds to wait for the connection to open
    SCHEMES = %w[http https].freeze

    attr_reader :url_string

    def initialize(url:)
      @url_string = url
    end

    def call
      check_url
    end

    private

    def check_url
      return invalid_uri_response unless valid_url?

      response
    rescue Errno::ECONNREFUSED => e
      rescued_response('Connection refused', e.message)
    rescue Errno::EINVAL => e
      rescued_response('Invalid argument', e.message)
    rescue Net::OpenTimeout => e
      rescued_response('Connection Timeout', e.message)
    rescue => e
      rescued_response(e.class.to_s, e.message)
    end

    def response
      Net::HTTP.start(uri.host, uri.port, nil, nil, nil, nil,
                      open_timeout: 1, use_ssl: uri.scheme == 'https') do |http|
        request = Net::HTTP::Get.new uri
        res = http.request request
        res.uri ||= uri # sometimes the uri is not set
        return res
      end
    end

    def invalid_uri_response
      UrlChecker::RecuedResponse.new(
        code: 'Invalid URL',
        message: INVALID_URI_MSG,
        uri: url_string
      )
    end

    def rescued_response(code, message)
      UrlChecker::RecuedResponse.new(
        code: code,
        message: message,
        uri: uri
      )
    end

    def valid_url?
      SCHEMES.include? uri.scheme
    rescue Addressable::URI::InvalidURIError
      false
    end

    def uri
      @uri ||= Addressable::URI.parse url_string
    end
  end
end
