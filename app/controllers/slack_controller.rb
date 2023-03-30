# https://github.com/basecamp/bc3-api/blob/master/sections/webhooks.md#webhooks
class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def webhook
    pp params
    # SlackEventProcessor.new(params).process

    head :ok
  end

  def oauth_redirect
    team = Team.find(params[:team])
    session["slack_oauth_team_id"] = team.id
    auth_url = oauth_client.auth_code.authorize_url(redirect_uri: redirect_uri, scope: "chat:write", user_scope: "identify")
    redirect_to auth_url, allow_other_host: true
  end

  def oauth_callback
    team = Team.find(session["slack_oauth_team_id"])
    token = oauth_client.auth_code.get_token(params[:code], redirect_uri: redirect_uri)
    team.oauth_token = token.to_hash
    team.service_id = token.params["team"]["id"]
    team.save!

    redirect_to edit_team_path(team), notice: "Connected to Slack team #{team.service_id}"
  rescue OAuth2::Error => ex
    redirect_to edit_team_path(team), alert: ex.message
  end

  def oauth_check
    team = Team.find(params[:team])
    client = BasecampClient.new(team)
    render plain: client.authorization
  end

  private

  def redirect_uri
    "#{ENV["GATEWOOD_HOST"]}/auth/slack/callback"
  end

  def oauth_client
    @client ||= SlackClient.oauth_client
  end
end
