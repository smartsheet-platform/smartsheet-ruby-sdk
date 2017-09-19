module Smartsheet
  module API
    class RequestSpec
      attr_reader :url_args, :params, :header_overrides, :body

      def initialize(params: {}, header_overrides: {}, body: nil, **url_args)
        @url_args = url_args
        @params = params
        @header_overrides = header_overrides
        @body = body
      end
    end
  end
end