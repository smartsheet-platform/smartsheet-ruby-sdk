module Smartsheet
  module Constants
    VERSION = '2.77.0'.freeze

    USER_AGENT = 'smartsheet-ruby-sdk'.freeze
    API_URL = 'https://api.smartsheet.com/2.0'.freeze
    GOV_API_URL = 'https://api.smartsheetgov.com/2.0'.freeze

    JSON_TYPE = 'application/json'.freeze
    EXCEL_TYPE = 'application/vnd.ms-excel'.freeze
    PDF_TYPE = 'application/pdf'.freeze
    CSV_TYPE = 'text/csv'.freeze
    OPENXML_SPREADSHEET_TYPE =
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'.freeze

    DEFAULT_MAX_RETRY_TIME = 15
    DEFAULT_BACKOFF_METHOD = proc { |iteration, _result| 2**iteration + rand }
  end
end