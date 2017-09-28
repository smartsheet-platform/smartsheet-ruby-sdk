require 'smartsheet/api/faraday_net_client'
require 'smartsheet/api/retrying_net_client_adapter'
require 'smartsheet/api/request_client'
require 'smartsheet/api/retry_logic'
require 'smartsheet/api/middleware/error_translator'
require 'smartsheet/api/middleware/response_parser'

require 'smartsheet/endpoints/contacts/contacts'
require 'smartsheet/endpoints/favorites/favorites'
require 'smartsheet/endpoints/folders/folders'
require 'smartsheet/endpoints/groups/groups'
require 'smartsheet/endpoints/home/home'
require 'smartsheet/endpoints/reports/reports'
require 'smartsheet/endpoints/search/search'
require 'smartsheet/endpoints/server_info/server_info'
require 'smartsheet/endpoints/sheets/sheets'
require 'smartsheet/endpoints/sights/sights'
require 'smartsheet/endpoints/templates/templates'
require 'smartsheet/endpoints/update_requests/update_requests'
require 'smartsheet/endpoints/users/users'
require 'smartsheet/endpoints/webhooks/webhooks'
require 'smartsheet/endpoints/workspaces/workspaces'


module Smartsheet
  class SmartsheetClient
    attr_reader :contacts, :favorites, :folders, :groups, :home, :reports, :search, :server_info, :sheets, :sights
    attr_reader :templates, :update_requests, :users, :webhooks, :workspaces

    def initialize(token)
      net_client = API::FaradayNetClient.new
      retry_logic = API::RetryLogic.new
      retrying_client = API::RetryingNetClientAdapter.new(net_client, retry_logic)
      request_client = API::RequestClient.new(token, retrying_client)

      @contacts = Contacts.new(request_client)
      @favorites = Favorites.new(request_client)
      @folders = Folders.new(request_client)
      @groups = Groups.new(request_client)
      @home = Home.new(request_client)
      @reports = Reports.new(request_client)
      @search = Search.new(request_client)
      @server_info = ServerInfo.new(request_client)
      @sheets = Sheets.new(request_client)
      @sights = Sights.new(request_client)
      @templates = Templates.new(request_client)
      @update_requests = UpdateRequests.new(request_client)
      @users = Users.new(request_client)
      @webhooks = Webhooks.new(request_client)
      @workspaces = Workspaces.new(request_client)
    end
  end
end
