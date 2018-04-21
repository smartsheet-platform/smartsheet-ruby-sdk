require 'cgi'
require 'faraday'

module Smartsheet
  module API
    # Specification for a file attachment by path, target filename, and MIME content type
    class PathFileSpec
      attr_reader :upload_io, :filename, :content_type, :file_length

      def initialize(path, filename, content_type)
        @file_length = File.size(path)
        @filename = (filename.nil? || filename.empty?) ? File.basename(path) : filename
        @upload_io = Faraday::UploadIO.new(path, content_type, CGI::escape(@filename))
        @content_type = content_type
      end
    end

    # Specification for a file attachment by {::File}, target filename, file length, and MIME
    # content type
    class ObjectFileSpec
      attr_reader :upload_io, :filename, :content_type, :file_length

      def initialize(file, filename, file_length, content_type)
        @file_length = file_length
        @filename = filename
        @upload_io = Faraday::UploadIO.new(file, content_type, CGI::escape(filename))
        @content_type = content_type
      end
    end

    # Specification for file sheet import by path and MIME content type
    class ImportPathFileSpec
      attr_reader :upload_io, :filename, :content_type, :file_length

      def initialize(path, content_type)
        @file_length = File.size(path)
        @filename = nil
        @upload_io = Faraday::UploadIO.new(path, content_type)
        @content_type = content_type
      end
    end

    # Specification for file sheet import by {::File}, file length, and MIME content type
    class ImportObjectFileSpec
      attr_reader :upload_io, :filename, :content_type, :file_length

      def initialize(file, file_length, content_type)
        @file_length = file_length
        @filename = nil
        @upload_io = Faraday::UploadIO.new(file, content_type)
        @content_type = content_type
      end
    end
  end
end
