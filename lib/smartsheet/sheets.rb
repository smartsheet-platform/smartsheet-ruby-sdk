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

    def get(id, params: {}, header_override: {})
      Faraday.get build_url('sheets', id), params do |req|
        build_headers(header_override).apply(req)
      end
    end

    def get_version(id, header_override: {})
      Faraday.get build_url('sheets', id, 'version'), {} do |req|
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

    def create_in_folder(folder_id, body: {}, header_override: {})
      Faraday.post build_url('folders', folder_id, 'sheets'), {} do |req|
        build_headers(header_override)
          .sending_json
          .apply(req)
        req.body = body.to_json
      end
    end

    def create_in_workspace(workspace_id, body: {}, header_override: {})
      Faraday.post build_url('workspaces', workspace_id, 'sheets'), {} do |req|
        build_headers(header_override)
          .sending_json
          .apply(req)
        req.body = body.to_json
      end
    end

    def update(id, body: {}, header_override: {})
      Faraday.put build_url('sheets', id), {} do |req|
        build_headers(header_override)
          .sending_json
          .apply(req)
        req.body = body.to_json
      end
    end

    def delete(id, header_override: {})
      Faraday.delete build_url('sheets', id), {} do |req|
        build_headers(header_override).apply(req)
      end
    end
  end
end
