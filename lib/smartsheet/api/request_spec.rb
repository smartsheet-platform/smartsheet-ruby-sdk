module Smartsheet
  module API
    class RequestSpec
      attr_reader :path_args, :params, :header_overrides, :body

      def initialize(path_args:, params:, header_overrides:, body:)
        @path_args = path_args
        @params = params
        @header_overrides = header_overrides
        @body = body
      end
    end
  end
end