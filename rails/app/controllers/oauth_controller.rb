class OauthController < ApplicationController
  def basecamp
    auth_url = client.auth_code.authorize_url(redirect_uri: redirect_uri, type: "web_server")
    redirect_to auth_url, allow_other_host: true
  end

  def basecamp_callback
    token = client.auth_code.get_token(params[:code], redirect_uri: redirect_uri, type: "web_server")
    token_hash = token.to_hash
    File.write('tmp/bc_token', token_hash.to_json)

    response = token.get('https://launchpad.37signals.com/authorization.json')
    render plain: response.parsed
  end

  def basecamp_check
    client = BasecampClient.new
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
