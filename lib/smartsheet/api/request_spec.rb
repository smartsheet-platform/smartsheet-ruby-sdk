module Smartsheet
  module API
    class RequestSpec
      attr_reader :header_overrides, :body, :path_args

      def initialize(path_args:, params:, header_overrides:, body:)
        @path_args = path_args
        @params = params
        @header_overrides = header_overrides
        @body = body
      end

      def attach_params(req)
        req.params = params
      end

      def attach_body(req)
        req.body(body) if body
      end

      private

      attr_reader :params
    end
  end
end