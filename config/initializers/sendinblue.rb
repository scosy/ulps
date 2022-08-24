SibApiV3Sdk.configure do |config|
  config.api_key['api-key'] = ENV["SIB_KEY"]
  config.api_key['partner-key'] = ENV["SIB_KEY"]
end