require 'json'
require 'awrence'
require 'cgi'

module Smartsheet
  module API
    class RequestSpec
      attr_reader :url_args, :params, :header_overrides, :body, :filename, :content_type, :file_options
      private :file_options

      def initialize(params: {}, header_overrides: {}, body: nil, file_options: {}, **url_args)
        @url_args = url_args
        @params = params
        @header_overrides = header_overrides
        @body = body
        @file_options = file_options

        validate_file_options
      end

      def filename
        file_options.key?(:filename) ? file_options[:filename] : File.basename(file_options[:path])
      end

      def content_type
        file_options.key?(:content_type) ? file_options[:content_type] : ''
      end

      def file_length
        valid_path? ? File.size(path) : file_options[:file_length]
      end

      def json_body
        if body.nil? || body.is_a?(String)
          body
        else
          body.to_camelback_keys.to_json
        end
      end

      def file_body
        Faraday::UploadIO.new(file, content_type, CGI::escape(filename))
      end

      private

      def validate_file_options
        unless file_options.empty? || valid_path? || valid_file?
          raise ArgumentError.new('Must specify either path or file, filename, and length')
        end

        if valid_path? && valid_file?
          raise ArgumentError.new('Cannot specify file by both path and object. ' +
              'Use either path or file, filename, and length')
        end
      end

      def file
        @file = valid_file? ? file_options[:file] : File.open(path) if @file.nil?

        @file
      end

      def path
        file_options[:path]
      end

      def valid_path?
        file_options.key?(:path)
      end

      def valid_file?
        file_options.key?(:file) &&
            file_options.key?(:file_length) &&
            file_options.key?(:filename)

      end


    end
  end
end