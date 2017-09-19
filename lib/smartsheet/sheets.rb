require_relative 'api/endpoints'

module Smartsheet
  # Sheet resource endpoints
  class Sheets
    extend Smartsheet::API::Endpoints

    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def_endpoints(
      list:
        { method: :get,
          url: ['sheets'],
          has_params: true },

      get:
        { method: :get,
          url: ['sheets', :sheet_id],
          has_params: true },

      get_version:
        { method: :get,
          url: ['sheets', :sheet_id, 'version'] },

      get_as_excel:
        { method: :get,
          url: ['sheets', :sheet_id],
          headers: { Accept: 'application/vnd.ms-excel' } },

      get_as_pdf:
        { method: :get,
          url: ['sheets', :sheet_id],
          has_params: true,
          headers: { Accept: 'application/pdf' } },

      get_as_csv:
        { method: :get,
          url: ['sheets', :sheet_id],
          headers: { Accept: 'text/csv' } },

      create:
        { method: :post,
          url: ['sheets'],
          body_type: :json },

      create_in_folder:
        { method: :post,
          url: ['folders', :folder_id, 'sheets'],
          body_type: :json },

      create_in_workspace:
        { method: :post,
          url: ['workspaces', :workspace_id, 'sheets'],
          body_type: :json },

      create_from_template:
        { method: :post,
          url: ['sheets'],
          has_params: true,
          body_type: :json },

      create_in_folder_from_template:
        { method: :post,
          url: ['folders', :folder_id, 'sheets'],
          has_params: true,
          body_type: :json },

      create_in_workspace_from_template:
        { method: :post,
          url: ['workspaces', :workspace_id, 'sheets'],
          has_params: true,
          body_type: :json },

      copy:
        { method: :post,
          url: ['sheets', :sheet_id, 'copy'],
          has_params: true,
          body_type: :json },

      update:
        { method: :put,
          url: ['sheets', :sheet_id],
          body_type: :json },

      delete:
        { method: :delete,
          url: ['sheets', :sheet_id] }
    )
  end
end
