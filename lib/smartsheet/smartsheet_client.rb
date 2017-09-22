require_relative 'api/net_client'
require_relative 'api/middleware/error_translator'
require_relative 'api/middleware/response_parser'

require_relative 'endpoints/sheets/sheets'
require_relative 'endpoints/server_info/server_info'
require_relative 'endpoints/contacts/contacts'

module Smartsheet
  class SmartsheetClient
    attr_reader :sheets, :server_info, :contacts

    def initialize(token)
      @net_client = API::NetClient.new(token)

      @sheets = Sheets.new(@net_client)
      @server_info = ServerInfo.new(@net_client)
      @contacts = Contacts.new(@net_client)
    end
  end
end
