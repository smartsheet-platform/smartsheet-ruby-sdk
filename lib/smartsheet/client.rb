require 'smartsheet/api/faraday_adapter/faraday_net_client'
require 'smartsheet/api/retry_net_client_decorator'
require 'smartsheet/api/response_net_client_decorator'
require 'smartsheet/api/request_client'
require 'smartsheet/api/retry_logic'
require 'smartsheet/api/request_logger'
require 'smartsheet/general_request'

require 'smartsheet/endpoints/contacts/contacts'
require 'smartsheet/endpoints/events/events'
require 'smartsheet/endpoints/favorites/favorites'
require 'smartsheet/endpoints/folders/folders'
require 'smartsheet/endpoints/groups/groups'
require 'smartsheet/endpoints/home/home'
require 'smartsheet/endpoints/reports/reports'
require 'smartsheet/endpoints/search/search'
require 'smartsheet/endpoints/server_info/server_info'
require 'smartsheet/endpoints/sheets/sheets'
require 'smartsheet/endpoints/sights/sights'
require 'smartsheet/endpoints/templates/templates'
require 'smartsheet/endpoints/token/token'
require 'smartsheet/endpoints/update_requests/update_requests'
require 'smartsheet/endpoints/users/users'
require 'smartsheet/endpoints/webhooks/webhooks'
require 'smartsheet/endpoints/workspaces/workspaces'


module Smartsheet
  # The entry point to the SDK. API endpoint categories are accessed through this object's readable
  # attributes.
  #
  # @!attribute [r] contacts
  #   @return [Contacts]
  # @!attribute [r] favorites
  #   @return [Favorites]
  # @!attribute [r] folders
  #   @return [Folders]
  # @!attribute [r] groups
  #   @return [Groups]
  # @!attribute [r] home
  #   @return [Home]
  # @!attribute [r] reports
  #   @return [Reports]
  # @!attribute [r] search
  #   @return [Search]
  # @!attribute [r] server_info
  #   @return [ServerInfo]
  # @!attribute [r] sheets
  #   @return [Sheets]
  # @!attribute [r] sights
  #   @return [Sights]
  # @!attribute [r] templates
  #   @return [Templates]
  # @!attribute [r] token
  #   @return [Token]
  # @!attribute [r] update_requests
  #   @return [UpdateRequests]
  # @!attribute [r] users
  #   @return [Users]
  # @!attribute [r] webhooks
  #   @return [Webhooks]
  # @!attribute [r] workspaces
  #   @return [Workspaces]
  class Client
    include GeneralRequest
    include Smartsheet::Constants

    attr_reader :contacts, :events, :favorites, :folders, :groups, :home, :reports, :search, :server_info,
                :sheets, :sights, :templates, :token, :update_requests, :users, :webhooks,
                :workspaces

    # @param token [String] access token for the API; if nil or empty, uses environment variable
    #   `SMARTSHEET_ACCESS_TOKEN`
    # @param logger [Logger] a logger to which request and response info will be recorded
    # @param log_full_body [Boolean] when true, request and response bodies will not be truncated in
    #   the logs
    # @param user_agent [String] the name of the application, sent as part of the user agent for
    #   requests; defaults as the name of the application
    # @param json_output [Boolean] when true, endpoints return raw JSON strings instead of hashes
    # @param assume_user [String] the email address of the user to impersonate; only available for
    #   admin roles
    # @param max_retry_time [Fixnum] overrides the maximum number of seconds during which eligible
    #   errors will be retried
    # @param backoff_method [Proc] overrides the backoff calculation method, accepting the index of
    #   the current retry attempt (0-based) and returning the number of seconds to wait before
    #   retrying the call again, or `:stop` to halt retrying and return the latest error.
    #
    #   Example - Wait 1 second before the first retry, 2 seconds before
    #   the second, and so on:
    #   ```ruby
    #   ->(x){ x + 1 }
    #   ```
    #
    #   Example - Try twice, then halt:
    #   ```ruby
    #   ->(x){ if x < 2 then x + 1 else :stop end }
    #   ```
    # @param base_url [String] overrides the base URL used when constructing API calls; for example,
    #   the default takes the form of `https://api.smartsheet.com/2.0`
    def initialize(
        token: nil,
        logger: nil,
        log_full_body: false,
        user_agent: nil,
        json_output: false,
        assume_user: nil,
        max_retry_time: nil,
        backoff_method: nil,
        base_url: API_URL
    )

      request_logger =
          logger ?
              API::RequestLogger.new(logger, log_full_body: log_full_body) :
              API::MuteRequestLogger.new

      token = token_env_var if token.nil? || token.empty?

      app_user_agent = user_agent.nil? ? File.basename($PROGRAM_NAME) : user_agent

      net_client = API::FaradayNetClient.new

      retry_logic = init_retry_logic(max_retry_time, backoff_method)

      retrying_client = API::RetryNetClientDecorator.new(
          net_client,
          retry_logic,
          logger: request_logger
      )

      response_client = API::ResponseNetClientDecorator.new(
          retrying_client,
          json_output: json_output,
          logger: request_logger
      )

      @client = API::RequestClient.new(
          token,
          response_client,
          base_url,
          app_user_agent: app_user_agent,
          assume_user: assume_user,
          logger: request_logger
      )
      build_categories
    end

    def inspect
      methods = (self.public_methods - Object.methods)
                    .sort
                    .map {|m| ':' + m.to_s}
                    .join(', ')

      "#<Smartsheet::Client:#{self.object_id} #{methods}>"
    end

    private

    attr_reader :client

    def build_categories
      @contacts = Contacts.new(client)
      @events = Events.new(client)
      @favorites = Favorites.new(client)
      @folders = Folders.new(client)
      @groups = Groups.new(client)
      @home = Home.new(client)
      @reports = Reports.new(client)
      @search = Search.new(client)
      @server_info = ServerInfo.new(client)
      @sheets = Sheets.new(client)
      @sights = Sights.new(client)
      @token = Token.new(client)
      @templates = Templates.new(client)
      @update_requests = UpdateRequests.new(client)
      @users = Users.new(client)
      @webhooks = Webhooks.new(client)
      @workspaces = Workspaces.new(client)
    end

    def init_retry_logic(max_retry_time, backoff_method)
      retry_opts = {}
      retry_opts[:max_retry_time] = max_retry_time unless max_retry_time.nil?
      retry_opts[:backoff_method] = backoff_method unless backoff_method.nil?

      API::RetryLogic.new(**retry_opts)
    end

    def token_env_var
      ENV['SMARTSHEET_ACCESS_TOKEN']
    end
  end
end
