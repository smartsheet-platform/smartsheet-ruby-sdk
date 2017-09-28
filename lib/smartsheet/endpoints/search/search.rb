module Smartsheet
  class Search
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def search_all(query:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['search'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params.merge({query: query})
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def search_sheet(sheet_id:, query:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['search', 'sheets', :sheet_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params.merge({query: query}),
          sheet_id: sheet_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end