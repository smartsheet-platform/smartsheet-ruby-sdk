require 'smartsheet/version'

module Smartsheet
  class SmartsheetClient
    def initialize(token)
      @net_client = NetClient.new(token)
    end

  end
end
