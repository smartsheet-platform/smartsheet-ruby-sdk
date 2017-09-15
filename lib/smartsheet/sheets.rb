require 'faraday'
require 'json'
require_relative 'api/urls'
require_relative 'api/headers'
require_relative 'api/endpoints'

module Smartsheet
  # Sheet endpoint resources
  class Sheets
    include Smartsheet::API::URLs
    include Smartsheet::API::Headers
    extend Smartsheet::API::Endpoints

    attr_reader :token
    private :token

    def initialize(token)
      @token = token
    end

    def_endpoint symbol: :list,
                 method: :get,
                 url: ['sheets'],
                 has_params: true

    def_endpoint symbol: :get,
                 method: :get,
                 url: ['sheets', :id],
                 has_params: true

    def_endpoint symbol: :get_version,
                 method: :get,
                 url: ['sheets', :id, 'version']

    def_endpoint symbol: :create,
                 method: :post,
                 url: ['sheets'],
                 body_type: :json

    def_endpoint symbol: :create_in_folder,
                 method: :post,
                 url: ['folders', :folder_id, 'sheets'],
                 body_type: :json

    def_endpoint symbol: :create_in_workspace,
                 method: :post,
                 url: ['workspaces', :workspace_id, 'sheets'],
                 body_type: :json

    def_endpoint symbol: :update,
                 method: :put,
                 url: ['sheets', :id],
                 body_type: :json

    def_endpoint symbol: :delete,
                 method: :delete,
                 url: ['sheets', :id]
  end
end
