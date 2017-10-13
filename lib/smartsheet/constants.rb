module Smartsheet
  module Constants
    VERSION = '1.0.0.beta.2'.freeze

    USER_AGENT = 'smartsheet-ruby-sdk'.freeze
    API_URL = 'https://api.smartsheet.com/2.0'.freeze

    JSON_TYPE = 'application/json'.freeze
    EXCEL_TYPE = 'application/vnd.ms-excel'.freeze
    PDF_TYPE = 'application/pdf'.freeze
    CSV_TYPE = 'text/csv'.freeze

    DEFAULT_MAX_RETRY_TIME = 15
    DEFAULT_BACKOFF_METHOD = proc { |iteration, _result| 2**iteration + rand }
  end
end