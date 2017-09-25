module Smartsheet
  module API
    class Error < StandardError; end

    # Errors for invalid requests, timeouts, etc.
    class RequestError < Error
      attr_reader :wrapped_exception

      def initialize(ex)
        super(ex.message)
        @wrapped_exception = ex
      end
    end
  end
end