require 'faraday'

module Smartsheet
  # Sheet endpoint resources
  class Sheet
    def self.list(token)
      Faraday.get('https://api.smartsheet.com/2.0/sheets/') do |req|
        req.headers = {
          :Accept => 'application/json',
          :Authorization => "Bearer #{token}",
          :'Content-Type' => 'application/json',
          :'User-Agent' => 'smartsheet-ruby-sdk'
        }
      end
    end
  end
end