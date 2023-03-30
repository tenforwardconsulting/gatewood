Slack::Web::Client.configure do |config|
  config.token = ENV['SLACK_BOT_TOKEN']
  config.user_agent = "Gatewood/1.0 Slack Ruby Client/2.1.0"
end

Slack::Events.configure do |config|
  config.signing_secret = ENV["SLACK_SIGNING_SECRET"]
end
