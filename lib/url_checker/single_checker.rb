# frozen_string_literal: true

module UrlChecker
  # Checks a single URL and returns the result
  class SingleChecker
    attr_reader :url_string, :uri

    def initialize(url:)
      @url_string = url
    end

    def call
      check_url
    end

    private

    def check_url
      @uri = URI(URI.escape url_string)
      return invalid_uri_response unless valid_url?
      response = Net::HTTP.get_response uri
      response.uri ||= uri # sometimes the uri is not set
      response
    rescue Errno::ECONNREFUSED => e
      rescued_response('Connection refused', e.message)
    rescue Errno::EINVAL => e
      rescued_response('Invalid argument', e.message)
    rescue => e
      rescued_response(e.class.to_s, e.message)
    end

    def invalid_uri_response
      rescued_response('Invalid URL', 'URL must begin with http')
    end

    def rescued_response(code, message)
      UrlChecker::RecuedResponse.new(
        code: code,
        message: message,
        uri: uri
      )
    end

    def valid_url?
      uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
    end
  end
end
