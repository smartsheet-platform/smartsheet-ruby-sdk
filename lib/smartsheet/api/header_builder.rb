require 'cgi'
require 'smartsheet/version'
require 'smartsheet/constants'

module Smartsheet
  module API
    # Constructs headers for accessing the Smartsheet API
    class HeaderBuilder
      include Smartsheet::Constants
      def initialize(token, endpoint_spec, request_spec, assume_user: nil)
        @token = token
        @endpoint_spec = endpoint_spec
        @request_spec = request_spec
        @assume_user = assume_user
      end

      def build
        base_headers
            .merge(assume_user)
            .merge(endpoint_headers)
            .merge(content_type)
            .merge(content_disposition)
            .merge(content_length)
            .merge(request_headers)
      end

      private

      attr_accessor :endpoint_spec, :request_spec
      attr_reader :token

      def base_headers
        base = {
            Accept: JSON_TYPE,
            'User-Agent': "#{USER_AGENT}/#{Smartsheet::VERSION}"
        }
        base[:Authorization] = "Bearer #{token}" if endpoint_spec.requires_auth?

        base
      end

      def assume_user
        if @assume_user.nil?
          {}
        else
          {'Assume-User': CGI::escape(@assume_user)}
        end
      end

      def endpoint_headers
        endpoint_spec.headers
      end

      def content_type
        if endpoint_spec.sending_json? && request_spec.body
          {'Content-Type': JSON_TYPE}
        elsif endpoint_spec.sending_file?
          {'Content-Type': request_spec.content_type}
        else
          {}
        end
      end

      def content_disposition
        if endpoint_spec.sending_file?
          {'Content-Disposition': "attachment; filename=\"#{CGI::escape(request_spec.filename)}\""}
        else
          {}
        end
      end

      def content_length
        if endpoint_spec.sending_file?
          {'Content-Length': request_spec.file_length.to_s}
        else
          {}
        end
      end

      def request_headers
        request_spec.header_overrides
      end
    end
  end
end