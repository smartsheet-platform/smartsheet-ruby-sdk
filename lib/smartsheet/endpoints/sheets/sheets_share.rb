require 'smartsheet/endpoints/share/share'

module Smartsheet
  class SheetsShare
    attr_reader :client, :url
    private :client, :url

    def initialize(client)
      @client = client

      @url = ['sheets', :sheet_id]
    end

    def delete(sheet_id:, share_id:, header_overrides: {})
      delete_share(
          share_id: share_id,
          url: url,
          header_overrides: header_overrides,
          sheet_id: sheet_id
      )
    end

    def get(sheet_id:, share_id:, header_overrides: {})
      get_share(
          share_id: share_id,
          url: url,
          header_overrides: header_overrides,
          sheet_id: sheet_id
      )
    end

    def list(sheet_id:, params: {}, header_overrides: {})
      list_share(
          url: url,
          header_overrides: header_overrides,
          params: params,
          sheet_id: sheet_id
      )
    end

    def create(sheet_id:, body:, params: {}, header_overrides: {})
      create_share(
          url: url,
          header_overrides: header_overrides,
          params: params,
          body: body,
          sheet_id: sheet_id
      )
    end

    def update(sheet_id:, share_id:, body:, header_overrides: {})
      update_share(
          share_id: share_id,
          url: url,
          header_overrides: header_overrides,
          body: body,
          sheet_id: sheet_id
      )
    end

    private

    include Smartsheet::Share
  end
end