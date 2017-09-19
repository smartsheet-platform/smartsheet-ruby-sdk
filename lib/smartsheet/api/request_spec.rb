module Smartsheet
  module API
    class RequestSpec
      attr_reader :url_args, :params, :header_overrides, :body

      def initialize(url_args:, params:, header_overrides:, body:)
        @url_args = url_args
        @params = params
        @header_overrides = header_overrides
        @body = body
      end
    end
  end
end