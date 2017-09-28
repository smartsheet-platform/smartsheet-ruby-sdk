require 'smartsheet/api/faraday_net_client'
require 'smartsheet/api/retrying_net_client_adapter'
require 'smartsheet/api/request_client'
require 'smartsheet/api/retry_logic'
require 'smartsheet/api/middleware/error_translator'
require 'smartsheet/api/middleware/response_parser'
require 'smartsheet/general_request'

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
    include GeneralRequest

    attr_reader :client, :contacts, :favorites, :folders, :groups, :home, :reports, :search, :server_info, :sheets
    attr_reader :sights, :templates, :update_requests, :users, :webhooks, :workspaces
    private :client


    def initialize(token: nil, assume_user: nil)
      token = token_env_var if token.nil?

      net_client = API::FaradayNetClient.new
      retry_logic = API::RetryLogic.new
      retrying_client = API::RetryingNetClientAdapter.new(net_client, retry_logic)
      @client = API::RequestClient.new(token, retrying_client)

      @contacts = Contacts.new(@client)
      @favorites = Favorites.new(@client)
      @folders = Folders.new(@client)
      @groups = Groups.new(@client)
      @home = Home.new(@client)
      @reports = Reports.new(@client)
      @search = Search.new(@client)
      @server_info = ServerInfo.new(@client)
      @sheets = Sheets.new(@client)
      @sights = Sights.new(@client)
      @templates = Templates.new(@client)
      @update_requests = UpdateRequests.new(@client)
      @users = Users.new(@client)
      @webhooks = Webhooks.new(@client)
      @workspaces = Workspaces.new(@client)
    end

    private

    def token_env_var
      ENV['SMARTSHEET_ACCESS_TOKEN']
    end
  end
end
