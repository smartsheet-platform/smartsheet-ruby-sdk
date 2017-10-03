require 'json'

module Smartsheet
  module API
    # Constructs bodys for accessing the Smartsheet API
    class BodyBuilder
      def initialize(endpoint_spec, request_spec)
        @endpoint_spec = endpoint_spec
        @request_spec = request_spec
      end

      def build
        if endpoint_spec.sending_json?
          json_body
        elsif endpoint_spec.sending_file?
          file_body
        else
          request_spec.body
        end
      end

      private

      attr_accessor :endpoint_spec, :request_spec

      def json_body
        return nil if request_spec.body.nil?

        request_spec.body.is_a?(String) ?
            request_spec.body :
            request_spec.body.to_json
      end
      
      def file_body
        Faraday::UploadIO.new(request_spec.file, request_spec.content_type, request_spec.filename)
      end
    end
  end
end