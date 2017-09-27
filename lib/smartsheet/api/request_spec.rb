module Smartsheet
  module API
    class RequestSpec
      attr_reader :url_args, :params, :header_overrides, :body, :filename, :content_type

      def initialize(params: {}, header_overrides: {}, body: nil, filename: nil, content_type: nil, **url_args)
        @url_args = url_args
        @params = params
        @header_overrides = header_overrides
        @body = body
        @filename = filename
        @content_type = content_type
      end
    end
  end
end