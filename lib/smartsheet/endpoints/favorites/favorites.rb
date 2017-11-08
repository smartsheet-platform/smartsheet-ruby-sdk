module Smartsheet
  # Favorites Endpoints
  # @see https://smartsheet-platform.github.io/api-docs/?ruby#favorites API Favorites Docs
  class Favorites
    attr_reader :client
    private :client

    def initialize(client)
      @client = client
    end

    def add(body:, params: {}, header_overrides: {})
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:post, ['favorites'], body_type: :json)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
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

    def remove_folder(folder_id:, params: {}, header_overrides: {})
      remove_favorite(
          url: ['folder', :folder_id],
          params: params,
          header_overrides: header_overrides,
          folder_id: folder_id
      )
    end

    def remove_report(report_id:, params: {}, header_overrides: {})
      remove_favorite(
          url: ['report', :report_id],
          params: params,
          header_overrides: header_overrides,
          report_id: report_id
      )
    end

    def remove_sheet(sheet_id:, params: {}, header_overrides: {})
      remove_favorite(
          url: ['sheet', :sheet_id],
          params: params,
          header_overrides: header_overrides,
          sheet_id: sheet_id
      )
    end

    def remove_sight(sight_id:, params: {}, header_overrides: {})
      remove_favorite(
          url: ['sight', :sight_id],
          params: params,
          header_overrides: header_overrides,
          sight_id: sight_id
      )
    end

    def remove_template(template_id:, params: {}, header_overrides: {})
      remove_favorite(
          url: ['template', :template_id],
          params: params,
          header_overrides: header_overrides,
          template_id: template_id
      )
    end

    def remove_workspace(workspace_id:, params: {}, header_overrides: {})
      remove_favorite(
          url: ['workspace', :workspace_id],
          params: params,
          header_overrides: header_overrides,
          workspace_id: workspace_id
      )
    end

    def remove_folders(folder_ids:, params: {}, header_overrides: {})
      remove_favorites(
          url: ['folder'],
          params: params,
          header_overrides: header_overrides,
          object_ids: folder_ids
      )
    end

    def remove_reports(report_ids:, params: {}, header_overrides: {})
      remove_favorites(
          url: ['report'],
          params: params,
          header_overrides: header_overrides,
          object_ids: report_ids
      )
    end

    def remove_sheets(sheet_ids:, params: {}, header_overrides: {})
      remove_favorites(
          url: ['sheet'],
          params: params,
          header_overrides: header_overrides,
          object_ids: sheet_ids
      )
    end

    def remove_sights(sight_ids:, params: {}, header_overrides: {})
      remove_favorites(
          url: ['sight'],
          params: params,
          header_overrides: header_overrides,
          object_ids: sight_ids
      )
    end

    def remove_templates(template_ids:, params: {}, header_overrides: {})
      remove_favorites(
          url: ['template'],
          params: params,
          header_overrides: header_overrides,
          object_ids: template_ids
      )
    end

    def remove_workspaces(workspace_ids:, params: {}, header_overrides: {})
      remove_favorites(
          url: ['workspace'],
          params: params,
          header_overrides: header_overrides,
          object_ids: workspace_ids
      )
    end

    private

    def remove_favorite(url:, params:, header_overrides:, **url_args)
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['favorites'] + url)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params,
          **url_args
      )
      client.make_request(endpoint_spec, request_spec)
    end

    def remove_favorites(object_ids:, url:, params:, header_overrides:)
      endpoint_spec = Smartsheet::API::EndpointSpec.new(:delete, ['favorites'] + url)
      request_spec = Smartsheet::API::RequestSpec.new(
          header_overrides: header_overrides,
          params: params.merge({objectIds: object_ids.join(',')})
      )
      client.make_request(endpoint_spec, request_spec)
    end
  end
end