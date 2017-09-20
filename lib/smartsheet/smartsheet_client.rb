require_relative 'api/net_client'

require_relative 'sheets'

module Smartsheet
  class SmartsheetClient
    attr_reader :sheets

    def initialize(token)
      @net_client = API::NetClient.new(token)

      @sheets = Sheets.new(@net_client)
    end
  end
end
