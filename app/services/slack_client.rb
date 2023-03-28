class SlackClient

  def self.oauth_client
    OAuth2::Client.new(ENV["SLACK_CLIENT_ID"], ENV["SLACK_CLIENT_SECRET"], {
      site: 'https://slack.com',
      authorize_url: '/oauth/v2/authorize',
      token_url: '/api/oauth.v2.access'
    })
  end

  def initialize(slack_team)
    @slack_team = slack_team
  end

  def post_message(channel: , text: )
    client.chat_postMessage(channel: channel, text: text)
  end

  def start!
    client.start!
  end

  def client
    @client ||= Slack::Web::Client.new(token: @slack_team.oauth_token["access_token"])
  end

end
