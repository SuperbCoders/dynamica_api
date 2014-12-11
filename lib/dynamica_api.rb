require 'active_support'
require 'active_support/json/decoding'
require 'action_dispatch/http/mime_type'
require 'action_controller/metal/http_authentication'

require 'hashie'
require 'ostruct'
require 'rest_client'

require 'dynamica_api/version'
require 'dynamica_api/base'
require 'dynamica_api/project'
require 'dynamica_api/item'
require 'dynamica_api/value'
require 'dynamica_api/forecast'
require 'dynamica_api/predicted_value'

module DynamicaAPI
  def self.config
    @@config ||= OpenStruct.new
  end

  self.config.url = 'http://dev-dynamica.onomnenado.ru'
  self.config.api_token = nil
end
