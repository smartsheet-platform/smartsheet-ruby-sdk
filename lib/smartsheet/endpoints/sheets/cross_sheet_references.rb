module Smartsheet
    # Cross-sheet References Endpoints
    # @see http://smartsheet-platform.github.io/api-docs/?ruby#cross-sheet-references API
    #   Cross-sheet References Docs
    class CrossSheetReferences
      attr_reader :client
      private :client
  
      def initialize(client)
        @client = client
      end
  
      def create(sheet_id:, body:, params: {}, header_overrides: {})
        endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['sheets', :sheet_id, 'crosssheetreferences'], body_type: :json)
        request_spec = Smartsheet::API::RequestSpec.new(
            header_overrides: header_overrides,
            params: params,
            body: body,
            sheet_id: sheet_id
        )
        client.make_request(endpoint_spec, request_spec)
      end
      
      def list(sheet_id:, params: {}, header_overrides: {})
        endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'crosssheetreferences'])
        request_spec = Smartsheet::API::RequestSpec.new(
            params: params,
            header_overrides: header_overrides,
            sheet_id: sheet_id
        )
        client.make_request(endpoint_spec, request_spec)
      end
      
      def get(sheet_id:, cross_sheet_reference_id:, params: {}, header_overrides: {})
        endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['sheets', :sheet_id, 'crosssheetreferences', :cross_sheet_reference_id])
        request_spec = Smartsheet::API::RequestSpec.new(
            params: params,
            header_overrides: header_overrides,
            sheet_id: sheet_id,
            cross_sheet_reference_id: cross_sheet_reference_id
        )
        client.make_request(endpoint_spec, request_spec)
      end
    end
  end