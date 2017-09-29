require 'json'
require 'awrence'

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
        if request_spec.body.nil? || request_spec.body.is_a?(String)
          request_spec.body
        else
          request_spec.body.to_camelback_keys.to_json
        end
      end
      
      def file_body
        Faraday::UploadIO.new(File.open(request_spec.filename), request_spec.content_type, request_spec.filename)
      end
    end
  end
end