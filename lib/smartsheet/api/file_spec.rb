require 'cgi'
# require 'faraday'

module Smartsheet
  module API
    class PathFileSpec
      attr_reader :upload_io, :filename, :content_type, :file_length

      def initialize(path, filename, content_type)
        @file_length = File.size(path)
        @filename = filename.nil? ? File.basename(path) : filename
        @upload_io = Faraday::UploadIO.new(path, content_type, CGI::escape(@filename))
        @content_type = content_type
      end
    end

    class ObjectFileSpec
      attr_reader :upload_io, :filename, :content_type, :file_length

      def initialize(file, filename, file_length, content_type)
        @file_length = file_length
        @filename = filename
        @upload_io = Faraday::UploadIO.new(file, content_type, CGI::escape(filename))
        @content_type = content_type
      end
    end
  end
end