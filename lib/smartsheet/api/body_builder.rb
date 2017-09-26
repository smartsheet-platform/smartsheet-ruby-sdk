module Smartsheet
  module API
    # Constructs bodys for accessing the Smartsheet API
    class BodyBuilder
      def initialize(endpoint_spec, request_spec)
        @endpoint_spec = endpoint_spec
        @request_spec = request_spec
      end

      def build
        endpoint_spec.file_upload? ?
            file_body :
            simple_body
      end

      private

      attr_accessor :endpoint_spec, :request_spec

      def simple_body
        request_spec.body if request_spec.body
      end
      
      def file_body
        Faraday::UploadIO.new(request_spec.filename, request_spec.content_type)
      end
    end
  end
end