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

  class ApiError < Error
    extend Forwardable

    def initialize(error_response)
      super(error_response.message)
      @error_response = error_response
    end

    def_delegators :error_response, :error_code, :message, :ref_id, :detail

    private

    attr_reader :error_response
  end
end