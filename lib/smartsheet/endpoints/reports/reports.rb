require_relative 'reports_share'

module Smartsheet
  class Reports

    attr_reader :client, :share
    private :client

    def initialize(client)
      @client = client

      @share = ReportsShare.new(client)
    end

    def get(report_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['reports', :report_id])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          report_id: report_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get_as_excel(report_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :get,
          ['reports', :report_id],
          headers: {Accept: 'application/vnd.ms-excel'}
      )
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          report_id: report_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get_as_csv(report_id:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(
          :get,
          ['reports', :report_id],
          headers: {Accept: 'text/csv'})
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          report_id: report_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list(params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['reports'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def get_publish_status(report_id:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['reports', :report_id, 'publish'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          report_id: report_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def set_publish_status(report_id:, body:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:put, ['reports', :report_id, 'publish'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          report_id: report_id
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def send_via_email(report_id:, body:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['reports', :report_id, 'emails'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body,
          report_id: report_id
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end