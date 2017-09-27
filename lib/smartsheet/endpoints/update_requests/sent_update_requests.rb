module Smartsheet
  class SentUpdateRequests
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def delete(sheet_id:, sent_update_request_id:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['sheets', :sheet_id, 'sentupdaterequests', :sent_update_request_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          sheet_id: sheet_id,
          sent_update_request_id: sent_update_request_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get(sheet_id:, sent_update_request_id:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'sentupdaterequests', :sent_update_request_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          sheet_id: sheet_id,
          sent_update_request_id: sent_update_request_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list(sheet_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'sentupdaterequests'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end