class SlackClient

  def self.oauth_client
    OAuth2::Client.new(ENV["SLACK_CLIENT_ID"], ENV["SLACK_CLIENT_SECRET"], {
      site: 'https://slack.com',
      authorize_url: '/oauth/v2/authorize',
      token_url: '/api/oauth.v2.access'
    })
  end

  def initialize
    Slack.configure do |config|
      config.token = ENV["SLACK_API_TOKEN"]
      config.logger = ::Logger.new(STDOUT)
      config.logger.level = Logger::DEBUG
    end
  end

  def start!
    client.start!
  end

  def configure

    client.on :hello do
      puts "Successfully connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
    end

    client.on :message do |data|
      case data.text
      when 'bot hi' then
        client.message(channel: data.channel, text: "Hi <@#{data.user}>!")
      when /^bot/ then
        client.message(channel: data.channel, text: "Sorry <@#{data.user}>, what?")
      end
    end

    client.on :close do |_data|
      puts "Client is about to disconnect"
    end

    client.on :closed do |_data|
      puts "Client has disconnected successfully!"
    end
  end

  private
  def client
    @client ||= Slack::RealTime::Client.new
  end


end