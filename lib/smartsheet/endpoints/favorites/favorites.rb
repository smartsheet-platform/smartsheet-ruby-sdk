module Smartsheet
  class Favorites
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def add(body:, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['favorites'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          body: body
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def list(params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:get, ['favorites'])
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def remove_folder(folder_id:, header_overrides: {})
      remove_favorite(
          url: ['folder', :folder_id],
          header_overrides: header_overrides,
          folder_id: folder_id
      )
    end

    def remove_report(report_id:, header_overrides: {})
      remove_favorite(
          url: ['report', :report_id],
          header_overrides: header_overrides,
          report_id: report_id
      )
    end

    def remove_sheet(sheet_id:, header_overrides: {})
      remove_favorite(
          url: ['sheet', :sheet_id],
          header_overrides: header_overrides,
          sheet_id: sheet_id
      )
    end

    def remove_sight(sight_id:, header_overrides: {})
      remove_favorite(
          url: ['sights', :sight_id],
          header_overrides: header_overrides,
          sight_id: sight_id
      )
    end

    def remove_template(template_id:, header_overrides: {})
      remove_favorite(
          url: ['template', :template_id],
          header_overrides: header_overrides,
          template_id: template_id
      )
    end

    def remove_workspace(workspace_id:, header_overrides: {})
      remove_favorite(
          url: ['workspace', :workspace_id],
          header_overrides: header_overrides,
          workspace_id: workspace_id
      )
    end

    def remove_folders(folder_ids:, header_overrides: {})
      remove_favorites(
          url: ['folder'],
          header_overrides: header_overrides,
          object_ids: folder_ids
      )
    end

    def remove_reports(report_ids:, header_overrides: {})
      remove_favorites(
          url: ['report'],
          header_overrides: header_overrides,
          object_ids: report_ids
      )
    end

    def remove_sheets(sheet_ids:, header_overrides: {})
      remove_favorites(
          url: ['sheet'],
          header_overrides: header_overrides,
          object_ids: sheet_ids
      )
    end

    def remove_sights(sight_ids:, header_overrides: {})
      remove_favorites(
          url: ['sights'],
          header_overrides: header_overrides,
          object_ids: sight_ids
      )
    end

    def remove_templates(template_ids:, header_overrides: {})
      remove_favorites(
          url: ['template'],
          header_overrides: header_overrides,
          object_ids: template_ids
      )
    end

    def remove_workspaces(workspace_ids:, header_overrides: {})
      remove_favorites(
          url: ['workspace'],
          header_overrides: header_overrides,
          object_ids: workspace_ids
      )
    end

    private

    def remove_favorite(url:, header_overrides:, **url_args)
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['favorites'] + url)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          **url_args
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def remove_favorites(object_ids:, url:, header_overrides:)
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['favorites'] + url)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: {objectIds: object_ids}
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end