require 'smartsheet/api/net_client'
require 'smartsheet/api/middleware/error_translator'
require 'smartsheet/api/middleware/response_parser'

require 'smartsheet/endpoints/sheets/sheets'
require 'smartsheet/endpoints/server_info/server_info'
require 'smartsheet/endpoints/contacts/contacts'
require 'smartsheet/endpoints/search/search'
require 'smartsheet/endpoints/folders/folders'
require 'smartsheet/endpoints/groups/groups'
require 'smartsheet/endpoints/home/home'
require 'smartsheet/endpoints/reports/reports'
require 'smartsheet/endpoints/sights/sights'

module Smartsheet
  class SmartsheetClient
    attr_reader :sheets, :server_info, :contacts, :search, :folders, :groups, :home, :reports, :sights

    def initialize(token)
      @net_client = API::NetClient.new(token)

      @sheets = Sheets.new(@net_client)
      @server_info = ServerInfo.new(@net_client)
      @contacts = Contacts.new(@net_client)
      @search = Search.new(@net_client)
      @folders = Folders.new(@net_client)
      @groups = Groups.new(@net_client)
      @home = Home.new(@net_client)
      @reports = Reports.new(@net_client)
      @sights = Sights.new(@net_client)
    end
  end
end
