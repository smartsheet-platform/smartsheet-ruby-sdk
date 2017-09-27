require 'smartsheet/api/net_client'
require 'smartsheet/api/middleware/error_translator'
require 'smartsheet/api/middleware/response_parser'

require 'smartsheet/endpoints/contacts/contacts'
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
    attr_reader :contacts, :folders, :groups, :home, :reports, :search, :server_info, :sheets, :sights, :templates
    attr_reader :update_requests, :users, :webhooks, :workspaces

    def initialize(token)
      @net_client = API::NetClient.new(token)

      @contacts = Contacts.new(@net_client)
      @folders = Folders.new(@net_client)
      @groups = Groups.new(@net_client)
      @home = Home.new(@net_client)
      @reports = Reports.new(@net_client)
      @search = Search.new(@net_client)
      @server_info = ServerInfo.new(@net_client)
      @sheets = Sheets.new(@net_client)
      @sights = Sights.new(@net_client)
      @templates = Templates.new(@net_client)
      @update_requests = UpdateRequests.new(@net_client)
      @users = Users.new(@net_client)
      @webhooks = Webhooks.new(@net_client)
      @workspaces = Workspaces.new(@net_client)
    end
  end
end
