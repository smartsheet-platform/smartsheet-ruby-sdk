require 'forwardable'

module Smartsheet
  class Error < StandardError; end

  # Errors for invalid requests, timeouts, etc.
  class RequestError < Error
    attr_reader :wrapped_exception

    def initialize(ex)
      super(ex.message)
      @wrapped_exception = ex
    end
  end

  class HttpResponseError < Error
    attr_reader :status_code, :reason_phrase, :headers

    def initialize(status_code:, reason_phrase:, headers:, message:)
      super(message)

      @status_code = status_code
      @reason_phrase = reason_phrase
      @headers = headers
    end
  end

  class ApiError < HttpResponseError
    extend Forwardable

    def initialize(error_response)
      super(
          status_code: error_response.status_code,
          reason_phrase: error_response.reason_phrase,
          headers: error_response.headers,
          message: error_response.message
      )
      @error_response = error_response
    end

    def_delegators :error_response, :error_code, :message, :ref_id, :detail

    private

    attr_reader :error_response
  end
end