require 'smartsheet/endpoints/share/share'

module Smartsheet
  class ReportsShare
    attr_reader :client, :url
    private :client, :url

    def initialize(client)
      @client = client

      @url = ['reports', :report_id]
    end

    def delete(report_id:, share_id:, header_overrides: {})
      delete_share(
          share_id: share_id,
          url: url,
          header_overrides: header_overrides,
          report_id: report_id
      )
    end

    def get(report_id:, share_id:, header_overrides: {})
      get_share(
          share_id: share_id,
          url: url,
          header_overrides: header_overrides,
          report_id: report_id
      )
    end

    def list(report_id:, params: {}, header_overrides: {})
      list_share(
          url: url,
          header_overrides: header_overrides,
          params: params,
          report_id: report_id
      )
    end

    def create(report_id:, body:, params: {}, header_overrides: {})
      create_share(
          url: url,
          header_overrides: header_overrides,
          params: params,
          body: body,
          report_id: report_id
      )
    end

    def update(report_id:, share_id:, body:, header_overrides: {})
      update_share(
          share_id: share_id,
          url: url,
          header_overrides: header_overrides,
          body: body,
          report_id: report_id
      )
    end

    private

    include Smartsheet::Share
  end
end