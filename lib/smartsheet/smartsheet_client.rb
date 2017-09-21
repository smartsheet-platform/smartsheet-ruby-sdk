require_relative 'api/net_client'
require_relative 'api/middleware/error_translator'
require_relative 'api/middleware/response_parser'

require_relative 'sheets'

module Smartsheet
  class SmartsheetClient
    attr_reader :sheets

    def initialize(token)
      conn = Faraday.new do |faraday|
        faraday.use API::Middleware::ErrorTranslator
        faraday.use API::Middleware::ResponseParser
        faraday.adapter Faraday.default_adapter
      end

      @net_client = API::NetClient.new(token, conn)

      @sheets = Sheets.new(@net_client)
    end
  end
end
