require_relative 'api/endpoint_spec'

module Smartsheet
  # Sheet resource endpoints
  class Sheets

    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def list(params: {}, header_overrides: {})
      spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets'])
      client.make_request(
        spec,
        params: params,
        header_overrides: header_overrides
      )
    end

    def get(sheet_id:, params: {}, header_overrides: {})
      spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id])
      client.make_request(
        spec,
        params: params,
        header_overrides: header_overrides,
        sheet_id: sheet_id
      )
    end

    def get_version(sheet_id:, header_overrides: {})
      spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'version'])
      client.make_request(
        spec,
        header_overrides: header_overrides,
        sheet_id: sheet_id
      )
    end

    def get_as_excel(sheet_id:, header_overrides: {})
      spec = Smartsheet::API::EndpointSpec.new(
        :get,
        ['sheets', :sheet_id],
        headers: { Accept: 'application/vnd.ms-excel' }
      )
      client.make_request(
        spec,
        header_overrides: header_overrides,
        sheet_id: sheet_id
      )
    end

    def get_as_pdf(sheet_id:, params: {}, header_overrides: {})
      spec = Smartsheet::API::EndpointSpec.new(
        :get,
        ['sheets', :sheet_id],
        headers: { Accept: 'application/pdf' }
      )
      client.make_request(
        spec,
        params: params,
        header_overrides: header_overrides,
        sheet_id: sheet_id
      )
    end

    def get_as_csv(sheet_id:, header_overrides: {})
      spec = Smartsheet::API::EndpointSpec.new(
        :get,
        ['sheets', :sheet_id],
        headers: { Accept: 'text/csv' }
      )
      client.make_request(
        spec,
        header_overrides: header_overrides,
        sheet_id: sheet_id
      )
    end

    def create(body:, header_overrides: {})
      spec = Smartsheet::API::EndpointSpec.new(
        :get,
        ['sheets'],
        body_type: :json
      )
      client.make_request(
        spec,
        header_overrides: header_overrides,
        body: body
      )
    end

    def create_in_folder(folder_id:, body:, header_overrides: {})
      spec = Smartsheet::API::EndpointSpec.new(
        :post,
        ['folders', :folder_id, 'sheets'],
        body_type: :json
      )
      client.make_request(
        spec,
        header_overrides: header_overrides,
        body: body,
        folder_id: folder_id
      )
    end

    def create_in_workspace(workspace_id:, body:, header_overrides: {})
      spec = Smartsheet::API::EndpointSpec.new(
        :post,
        ['workspaces', :workspace_id, 'sheets'],
        body_type: :json
      )
      client.make_request(
        spec,
        header_overrides: header_overrides,
        body: body,
        workspace_id: workspace_id
      )
    end

    def create_from_template(body:, params: {}, header_overrides: {})
      spec = Smartsheet::API::EndpointSpec.new(
        :get,
        ['sheets'],
        body_type: :json
      )
      client.make_request(
        spec,
        params: params,
        header_overrides: header_overrides,
        body: body
      )
    end

    def create_in_folder_from_template(folder_id:, body:, params: {}, header_overrides: {})
      spec = Smartsheet::API::EndpointSpec.new(
        :post,
        ['folders', :folder_id, 'sheets'],
        body_type: :json
      )
      client.make_request(
        spec,
        params: params,
        header_overrides: header_overrides,
        body: body,
        folder_id: folder_id
      )
    end

    def create_in_workspace_from_template(workspace_id:, body:, params: {}, header_overrides: {})
      spec = Smartsheet::API::EndpointSpec.new(
        :post,
        ['workspaces', :workspace_id, 'sheets'],
        body_type: :json
      )
      client.make_request(
        spec,
        params: params,
        header_overrides: header_overrides,
        body: body,
        workspace_id: workspace_id
      )
    end

    def copy(sheet_id:, body:, params: {}, header_overrides: {})
      spec = Smartsheet::API::EndpointSpec.new(
        :post,
        ['sheets', :sheet_id, 'copy'],
        body_type: :json
      )
      client.make_request(
        spec,
        params: params,
        header_overrides: header_overrides,
        body: body,
        sheet_id: sheet_id
      )
    end

    def update(sheet_id:, body:, header_overrides: {})
      spec = Smartsheet::API::EndpointSpec.new(
        :put,
        ['sheets', :sheet_id],
        body_type: :json
      )
      client.make_request(
        spec,
        header_overrides: header_overrides,
        body: body,
        sheet_id: sheet_id
      )
    end

    def delete(sheet_id:, header_overrides: {})
      spec = Smartsheet::API::EndpointSpec.new(
        :delete,
        ['sheets', :sheet_id]
      )
      client.make_request(
        spec,
        header_overrides: header_overrides,
        sheet_id: sheet_id
      )
    end
  end
end
