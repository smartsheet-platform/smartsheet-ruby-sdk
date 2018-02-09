require 'json'
require 'awrence'

module Smartsheet
  module API
    # Specification for a single API request's arguments
    class RequestSpec
      attr_reader :file_spec, :url_args, :params, :header_overrides, :body
      private :file_spec

      # @param params [Hash{Object=>Object}] URL parameters for the request
      #
      # @param header_overrides [Hash{Object=>Object}] HTTP headers to sent in the request; these
      #   override all default headers sent by the SDK and the particular endpoint
      # 
      # @param body [Object] The body of the HTTP request, to be interpreted based on the endpoint
      #   specification
      # 
      # @param file_spec [PathFileSpec, ObjectFileSpec] Specification for files, to be used when
      #   an endpoint requires a file upload
      #
      # @param url_args [Hash{Symbol=>Object}] Values that will be used to fill in parameterized
      #   segments of an endpoint path specificaiton
      def initialize(params: {}, header_overrides: {}, body: nil, file_spec: nil, **url_args)
        @url_args = url_args
        @params = params
        @header_overrides = header_overrides
        @body = body
        @file_spec = file_spec
      end

      def filename
        file_spec.filename
      end

      def content_type
        file_spec.content_type
      end

      def file_length
        file_spec.file_length
      end

      def json_body
        if body.nil? || body.is_a?(String)
          body
        else
          body.to_camelback_keys.to_json
        end
      end

      def file_body
        file_spec.upload_io
      end
    end
  end
end
