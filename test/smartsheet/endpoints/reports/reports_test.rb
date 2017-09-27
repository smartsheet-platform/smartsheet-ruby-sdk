require_relative '../../../test_helper'
require_relative '../endpoint_test_helper'

class ReportsTest < Minitest::Test
  extend Smartsheet::Test::EndpointHelper

  attr_accessor :mock_client
  attr_accessor :smartsheet_client

  def category
    smartsheet_client.reports
  end

  def self.endpoints
    [
        {
            symbol: :get,
            method: :get,
            url: ['reports', :report_id],
            args: {report_id: 123},
            has_params: true,
            headers: nil
        },
        {
            symbol: :get_as_excel,
            method: :get,
            url: ['reports', :report_id],
            args: {report_id: 123},
            has_params: true,
            headers: {Accept: 'application/vnd.ms-excel'}
        },
        {
            symbol: :get_as_csv,
            method: :get,
            url: ['reports', :report_id],
            args: {report_id: 123},
            has_params: true,
            headers: {Accept: 'text/csv'}
        },
        {
            symbol: :list,
            method: :get,
            url: ['reports'],
            args: {},
            has_params: true,
            headers: nil
        },
        {
            symbol: :get_publish_status,
            method: :get,
            url: ['reports', :report_id, 'publish'],
            args: {report_id: 123},
            has_params: false,
            headers: nil
        },
        {
            symbol: :set_publish_status,
            method: :put,
            url: ['reports', :report_id, 'publish'],
            args: {report_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
        {
            symbol: :send_via_email,
            method: :post,
            url: ['reports', :report_id, 'emails'],
            args: {report_id: 123, body: {}},
            has_params: false,
            headers: nil
        },
    ]
  end

  define_setup
  define_endpoints_tests
end


