class OauthController < ApplicationController
  def basecamp
    puts "****************#{redirect_uri}"
    team = Team.find(params[:team])
    session["basecamp_oauth_team_id"] = team.id
    auth_url = client.auth_code.authorize_url(redirect_uri: redirect_uri, type: "web_server")
    redirect_to auth_url, allow_other_host: true
  end

  def basecamp_callback
    token = client.auth_code.get_token(params[:code], redirect_uri: redirect_uri, type: "web_server")
    response = token.get('https://launchpad.37signals.com/authorization.json')
    authorization = JSON.parse(response.body)

    team = Team.find(session["basecamp_oauth_team_id"])
    team.oauth_token = token.to_hash
    team.service_id = authorization["accounts"].first["id"]
    team.save!

    redirect_to edit_team_path(team), notice: "Connected to Basecampe team #{team.service_id}"
  rescue OAuth2::Error => ex
    redirect_to edit_team_path(team), alert: ex.message
  end

  def basecamp_check
    team = Team.find(params[:team])
    client = BasecampClient.new(team)
    render plain: client.authorization
  end

  private

  def client
    @client ||= BasecampClient.oauth_client
  end

  def redirect_uri
    "#{ENV["GATEWOOD_HOST"]}/auth/basecamp/callback"
  end
end
