require 'forwardable'

module Smartsheet
  # Top-level Smartsheet Error
  class Error < StandardError; end

  # Errors for invalid requests, timeouts, etc.
  class RequestError < Error
    attr_reader :wrapped_exception

    def initialize(ex)
      super(ex.message)
      @wrapped_exception = ex
    end
  end

  # Errors for generic HTTP error codes
  # @!attribute [r] status_code
  #   @return [Fixnum] HTTP status code
  # @!attribute [r] reason_phrase
  #   @return [String] HTTP reason phrase
  # @!attribute [r] headers
  #   @return [Hash] HTTP response headers
  class HttpResponseError < Error
    attr_reader :status_code, :reason_phrase, :headers

    def initialize(status_code:, reason_phrase:, headers:, message:)
      super(message)

      @status_code = status_code
      @reason_phrase = reason_phrase
      @headers = headers
    end
  end

  # Errors for Smartsheet API error objects
  # @see https://smartsheet-platform.github.io/api-docs/?ruby#error-object API Error Object Docs
  #
  # @!attribute [r] error_code
  #   @return [Fixnum] Smartsheet error code
  #   @see https://smartsheet-platform.github.io/api-docs/?ruby#complete-error-code-list API Error
  #     Code Docs
  # @!attribute [r] message
  #   @return [String] Smartsheet error message
  #   @see https://smartsheet-platform.github.io/api-docs/?ruby#complete-error-code-list API Error
  #     Code Docs
  # @!attribute [r] ref_id
  #   @return [String] Smartsheet error reference ID
  # @!attribute [r] detail
  #   @return [Hash, Array, nil] optional details for some error scenarios
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