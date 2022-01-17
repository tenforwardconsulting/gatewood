class BasecampClient
  include HTTParty
  base_uri "https://3.basecampapi.com/"

  def self.oauth_client
    OAuth2::Client.new(ENV["BASECAMP_CLIENT_ID"], ENV["BASECAMP_CLIENT_SECRET"], {
      site: 'https://launchpad.37signals.com',
      authorize_url: '/authorization/new',
      token_url: '/authorization/token'
    })
  end

  def initialize
    @options = {
      headers: {
        "Authorization" => "Bearer #{token.token}",
        "User-Agent" => "Grandma Gatewood (brian@tenforwardconsulting.com)"
      }
    }
  end

  def endpoint
  end

  def list_projects
    response = self.class.get("/3439565/projects.json", @options)
  end

  def create_todo

  end

  def create_todolist

  end

  def token
    @token ||= begin
      token_hash = JSON.parse(File.read('tmp/bc_token'))
      token = OAuth2::AccessToken.from_hash(client, token_hash)
    end
  end

  def client
    @client ||= self.class.oauth_client
  end

end