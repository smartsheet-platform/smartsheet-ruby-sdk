require 'smartsheet/endpoints/share/share'

module Smartsheet
  class WorkspacesShare
    attr_reader :client
    private :client

    URL = ['workspaces', :workspace_id].freeze

    def initialize(client)
      @client = client
    end

    def delete(workspace_id:, share_id:, header_overrides: {})
      delete_share(
          share_id: share_id,
          url: URL,
          header_overrides: header_overrides,
          workspace_id: workspace_id
      )
    end

    def get(workspace_id:, share_id:, header_overrides: {})
      get_share(
          share_id: share_id,
          url: URL,
          header_overrides: header_overrides,
          workspace_id: workspace_id
      )
    end

    def list(workspace_id:, params: {}, header_overrides: {})
      list_share(
          url: URL,
          header_overrides: header_overrides,
          params: params,
          workspace_id: workspace_id
      )
    end

    def create(workspace_id:, body:, params: {}, header_overrides: {})
      create_share(
          url: URL,
          header_overrides: header_overrides,
          params: params,
          body: body,
          workspace_id: workspace_id
      )
    end

    def update(workspace_id:, share_id:, body:, header_overrides: {})
      update_share(
          share_id: share_id,
          url: URL,
          header_overrides: header_overrides,
          body: body,
          workspace_id: workspace_id
      )
    end

    private

    include Smartsheet::Share
  end
end