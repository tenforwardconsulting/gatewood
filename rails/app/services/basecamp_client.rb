class BasecampClient
  include HTTParty
  base_uri "https://3.basecampapi.com/"
  attr_accessor :project

  def self.oauth_client
    OAuth2::Client.new(ENV["BASECAMP_CLIENT_ID"], ENV["BASECAMP_CLIENT_SECRET"], {
      site: 'https://launchpad.37signals.com',
      authorize_url: '/authorization/new',
      token_url: '/authorization/token'
    })
  end

  def initialize(team, project=nil)
    raise "Please use a basecamp team" unless team.basecamp?
    @team = team
    @project = project
    @headers = {
        "Authorization" => "Bearer #{token.token}",
        "User-Agent" => "Grandma Gatewood (brian@tenforwardconsulting.com)",
        "Content-Type" => "application/json; charset=utf-8"
    }
    self.class.base_uri "https://3.basecampapi.com/#{@team.service_id}/"
  end

  def projects
    @projects_cache ||= self.class.get("/projects.json", headers: @headers)
  end

  def people
    raise "Please set basecamp_client.project" if @project.nil?
    @people_cache ||= self.class.get("/projects/#{@project.basecamp_bucket_id}/people.json", headers: @headers)
  end

  def create_todo(text:, due_date:, assigned_to: [], source: "unknown")
    raise "Please set basecamp_client.project" if @project.nil?
    endpoint = "/buckets/#{@project.basecamp_bucket_id}/todolists/#{@project.basecamp_todolist_id}/todos.json"
    body = {
      content: text,
      description: "<div><em>Created by Gatewood (via #{source})</em></div>",
      due_on: due_date.strftime("%Y-%m-%d"),
      assignee_ids:  assigned_to,
      notify: true
    }.to_json
    self.class.post(endpoint, headers: @headers, body: body)
  end

  def token
    @token ||= begin
      token_hash = @team.oauth_token
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