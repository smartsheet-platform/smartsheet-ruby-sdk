require_relative 'api/endpoints'

module Smartsheet
  # Sheet resource endpoints
  class Sheets
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
                 url: ['sheets', :sheet_id],
                 has_params: true

    def_endpoint symbol: :get_version,
                 method: :get,
                 url: ['sheets', :sheet_id, 'version']

    def_endpoint symbol: :get_as_excel,
                 method: :get,
                 url: ['sheets', :sheet_id],
                 headers: { Accept: 'application/vnd.ms-excel' }

    def_endpoint symbol: :get_as_pdf,
                 method: :get,
                 url: ['sheets', :sheet_id],
                 has_params: true,
                 headers: { Accept: 'application/pdf' }

    def_endpoint symbol: :get_as_csv,
                 method: :get,
                 url: ['sheets', :sheet_id],
                 headers: { Accept: 'text/csv' }

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

    def_endpoint symbol: :create_from_template,
                 method: :post,
                 url: ['sheets'],
                 has_params: true,
                 body_type: :json

    def_endpoint symbol: :create_in_folder_from_template,
                 method: :post,
                 url: ['folders', :folder_id, 'sheets'],
                 has_params: true,
                 body_type: :json

    def_endpoint symbol: :create_in_workspace_from_template,
                 method: :post,
                 url: ['workspaces', :workspace_id, 'sheets'],
                 has_params: true,
                 body_type: :json

    def_endpoint symbol: :copy,
                 method: :post,
                 url: ['sheets', :sheet_id, 'copy'],
                 has_params: true,
                 body_type: :json

    def_endpoint symbol: :update,
                 method: :put,
                 url: ['sheets', :sheet_id],
                 body_type: :json

    def_endpoint symbol: :delete,
                 method: :delete,
                 url: ['sheets', :sheet_id]
  end
end
