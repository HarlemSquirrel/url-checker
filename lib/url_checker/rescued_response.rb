# frozen_string_literal: true

module UrlChecker
  # Checks a single URL and returns the result
  class RecuedResponse
    attr_reader :code, :message, :uri

    def initialize(code:, message:, uri:)
      @code = code
      @message = message
      @uri = uri
    end
  end
end
