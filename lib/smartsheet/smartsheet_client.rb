require 'smartsheet/api/net_client'
require 'smartsheet/api/retry_logic'
require 'smartsheet/api/retrying_net_client'
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
require 'smartsheet/endpoints/token/token'
require 'smartsheet/endpoints/update_requests/update_requests'
require 'smartsheet/endpoints/users/users'
require 'smartsheet/endpoints/webhooks/webhooks'
require 'smartsheet/endpoints/workspaces/workspaces'


module Smartsheet
  class SmartsheetClient
    attr_reader :contacts, :favorites, :folders, :groups, :home, :reports, :search, :server_info, :sheets, :sights
    attr_reader :templates, :token, :update_requests, :users, :webhooks, :workspaces

    def initialize(token)
      net_client = API::NetClient.new(token)
      retry_logic = API::RetryLogic.new
      retrying_client = API::RetryingNetClient.new(net_client, retry_logic)

      @contacts = Contacts.new(retrying_client)
      @favorites = Favorites.new(retrying_client)
      @folders = Folders.new(retrying_client)
      @groups = Groups.new(retrying_client)
      @home = Home.new(retrying_client)
      @reports = Reports.new(retrying_client)
      @search = Search.new(retrying_client)
      @server_info = ServerInfo.new(retrying_client)
      @sheets = Sheets.new(retrying_client)
      @sights = Sights.new(retrying_client)
      @templates = Templates.new(retrying_client)
      @token = Token.new(retrying_client)
      @update_requests = UpdateRequests.new(retrying_client)
      @users = Users.new(retrying_client)
      @webhooks = Webhooks.new(retrying_client)
      @workspaces = Workspaces.new(retrying_client)
    end
  end
end
