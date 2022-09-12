# frozen_string_literal: true

# Documentation : ULPS Prospects list for id is 13, clients is 14

SibApiV3Sdk.configure do |config|
  config.api_key['api-key'] = ENV.fetch('SIB_KEY', nil)
  config.api_key['partner-key'] = ENV.fetch('SIB_KEY', nil)
end
