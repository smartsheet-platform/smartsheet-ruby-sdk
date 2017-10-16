require 'smartsheet/endpoints/share/share'

module Smartsheet
  # Report Sharing Endpoints
  # @see https://smartsheet-platform.github.io/api-docs/?ruby#report-sharing API Report Sharing Docs
  class ReportsShare
    attr_reader :client
    private :client

    URL = ['reports', :report_id].freeze

    def initialize(client)
      @client = client
    end

    def delete(report_id:, share_id:, params: {}, header_overrides: {})
      delete_share(
          share_id: share_id,
          url: URL,
          params: params,
          header_overrides: header_overrides,
          report_id: report_id
      )
    end

    def get(report_id:, share_id:, params: {}, header_overrides: {})
      get_share(
          share_id: share_id,
          url: URL,
          params: params,
          header_overrides: header_overrides,
          report_id: report_id
      )
    end

    def list(report_id:, params: {}, header_overrides: {})
      list_share(
          url: URL,
          header_overrides: header_overrides,
          params: params,
          report_id: report_id
      )
    end

    def create(report_id:, body:, params: {}, header_overrides: {})
      create_share(
          url: URL,
          header_overrides: header_overrides,
          params: params,
          body: body,
          report_id: report_id
      )
    end

    def update(report_id:, share_id:, body:, params: {}, header_overrides: {})
      update_share(
          share_id: share_id,
          url: URL,
          params: params,
          header_overrides: header_overrides,
          body: body,
          report_id: report_id
      )
    end

    private

    include Smartsheet::Share
  end
end