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
    token_hash = JSON.parse(File.read('tmp/bc_token'))
    token = OAuth2::AccessToken.from_hash(client, token_hash)
    response = token.get('https://launchpad.37signals.com/authorization.json')
    render plain: response.parsed
  end

  private
  def client
    client = OAuth2::Client.new(ENV["BASECAMP_CLIENT_ID"], ENV["BASECAMP_CLIENT_SECRET"], {
      site: 'https://launchpad.37signals.com',
      authorize_url: '/authorization/new',
      token_url: '/authorization/token'
    })
  end

  def redirect_uri
    "https://gatewood.ngrok.io/auth/basecamp/callback"
  end
end
