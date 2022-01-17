class BasecampClient
  include HTTParty
  debug_output $stdout
  base_uri "https://3.basecampapi.com/"
  attr_accessor :project

  def self.oauth_client
    OAuth2::Client.new(ENV["BASECAMP_CLIENT_ID"], ENV["BASECAMP_CLIENT_SECRET"], {
      site: 'https://launchpad.37signals.com',
      authorize_url: '/authorization/new',
      token_url: '/authorization/token'
    })
  end

  def initialize(project: nil)
    @project = project
    @headers = {
        "Authorization" => "Bearer #{token.token}",
        "User-Agent" => "Grandma Gatewood (brian@tenforwardconsulting.com)",
        "Content-Type" => "application/json"
    }
    self.class.base_uri "https://3.basecampapi.com/#{ENV["BASECAMP_TEAM"]}/"
  end

  def list_projects
    response = self.class.get("/projects.json", headers: @headers)
  end

  def create_todo(name, due_date)
    endpoint = "/buckets/#{@project.basecamp_bucket_id}/todolists/#{@project.basecamp_todolist_id}/todos.json"
    body = {
      "content": name,
      "description": "<div><em>Created by Gatewood</em></div>",
      "due_on": due_date.strftime("%Y-%m-%d")
    }.to_json
    self.class.post(endpoint, headers: @headers, body: body)
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

  def authorization
    token.get('https://launchpad.37signals.com/authorization.json').parsed
  end

end