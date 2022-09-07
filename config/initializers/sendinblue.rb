# frozen_string_literal: true

SibApiV3Sdk.configure do |config|
  config.api_key['api-key'] = ENV.fetch('SIB_KEY', nil)
  config.api_key['partner-key'] = ENV.fetch('SIB_KEY', nil)
end
