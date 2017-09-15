require 'faraday'
require 'json'
require_relative 'api/urls'
require_relative 'api/headers'

module Smartsheet
  # Sheet endpoint resources
  class Sheets
    include Smartsheet::API::URLs
    include Smartsheet::API::Headers

    attr_reader :token
    private :token

    def initialize(token)
      @token = token
    end

    def list(params: {}, header_override: {})
      Faraday.get build_url('sheets'), params do |req|
        build_headers(header_override).apply(req)
      end
    end

    def get(params: {}, header_override: {}, **path_context)
      Faraday.get build_url('sheets', :id, context: path_context), params do |req|
        build_headers(header_override).apply(req)
      end
    end

    def get_version(header_override: {}, **path_context)
      Faraday.get build_url('sheets', :id, 'version', context: path_context), {} do |req|
        build_headers(header_override).apply(req)
      end
    end

    def create(body: {}, header_override: {})
      Faraday.post build_url('sheets'), {} do |req|
        build_headers(header_override)
          .sending_json
          .apply(req)
        req.body = body.to_json
      end
    end

    def create_in_folder(body: {}, header_override: {}, **path_context)
      Faraday.post build_url('folders', :folder_id, 'sheets', context: path_context), {} do |req|
        build_headers(header_override)
          .sending_json
          .apply(req)
        req.body = body.to_json
      end
    end

    def create_in_workspace(body: {}, header_override: {}, **path_context)
      url = build_url('workspaces', :workspace_id, 'sheets', context: path_context)
      Faraday.post url, {} do |req|
        build_headers(header_override)
          .sending_json
          .apply(req)
        req.body = body.to_json
      end
    end

    def update(body: {}, header_override: {}, **path_context)
      Faraday.put build_url('sheets', :id, context: path_context), {} do |req|
        build_headers(header_override)
          .sending_json
          .apply(req)
        req.body = body.to_json
      end
    end

    def delete(header_override: {}, **path_context)
      Faraday.delete build_url('sheets', :id, context: path_context), {} do |req|
        build_headers(header_override).apply(req)
      end
    end
  end
end
