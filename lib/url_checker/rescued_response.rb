# frozen_string_literal: true

module UrlChecker
  # Checks a single URL and returns the result
  class RecuedResponse
    attr_reader :code, :message, :uri

    def initialize(code:, message:, uri:)
      raise TypeError, 'uri is not a URI' unless uri.is_a? Addressable::URI
      @code = code
      @message = message
      @uri = uri
    end
  end
end
