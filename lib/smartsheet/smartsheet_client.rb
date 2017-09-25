require_relative 'api/net_client'
require_relative 'api/middleware/error_translator'
require_relative 'api/middleware/response_parser'

require_relative 'endpoints/sheets/sheets'

module Smartsheet
  class SmartsheetClient
    attr_reader :sheets

    def initialize(token)
      @net_client = API::NetClient.new(token)

      @sheets = Sheets.new(@net_client)
    end
  end
end
