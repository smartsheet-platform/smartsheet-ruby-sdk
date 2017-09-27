require 'smartsheet/api/net_client'
require 'smartsheet/api/retrying_net_client'
require 'smartsheet/api/middleware/error_translator'
require 'smartsheet/api/middleware/response_parser'

require 'smartsheet/endpoints/sheets/sheets'
require 'smartsheet/endpoints/server_info/server_info'
require 'smartsheet/endpoints/contacts/contacts'
require 'smartsheet/endpoints/search/search'
require 'smartsheet/endpoints/favorites/favorites'
require 'smartsheet/endpoints/folders/folders'
require 'smartsheet/endpoints/groups/groups'

module Smartsheet
  class SmartsheetClient
    attr_reader :sheets, :server_info, :contacts, :search, :favorites, :folders, :groups

    def initialize(token)
      net_client = API::NetClient.new(token)
      retry_logic = API::RetryLogic.new
      retrying_client = API::RetryingNetClient.new(net_client, retry_logic)

      @sheets = Sheets.new(retrying_client)
      @server_info = ServerInfo.new(retrying_client)
      @contacts = Contacts.new(retrying_client)
      @search = Search.new(retrying_client)
      @favorites = Favorites.new(retrying_client)
      @folders = Folders.new(retrying_client)
      @groups = Groups.new(retrying_client)
    end
  end
end
