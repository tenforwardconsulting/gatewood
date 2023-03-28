class SlackEventProcessor
  def initialize(params)
    @slack_event = SlackEvent.new(params[:event])
  end

  def process
    @command = CommandParser.parse(@slack_event.text)
    if find_project.nil?
      post_reply("Oww sheesh, I don't know what Basecamp to use in this channel!") and return
    end

    if @command.due_date.nil?
      post_reply("Oh no, you know it won't get done without a due date!") and return
    end

    response = create_todo
    if response.success?
      post_reply "You got it! #{response.parsed_response["app_url"]}"
    else
      post_reply "Uh oh :( #{response.code}: #{response.body}"
    end

  end

  def find_project
    @project = Project.where(slack_channel_id: @slack_event.channel).first
  end

  # TODO need to get the real slack team
  def create_todo
    ts = @slack_event.ts.gsub(".","")
    BasecampClient.new(@project.basecamp_team, @project).create_todo(
      text: @command.text,
      due_date: @command.due_date,
      source: "<a href=\"https://#{@slack_event.team.name}.slack.com/archives/#{@slack_event.channel}/p#{ts}\">Slack</a>"
    )
  end

  def post_reply(text)
    slack_client.post_message(channel: @slack_event.channel, text: text)
  end

  def slack_client
    @slack_client ||= SlackClient.new(@slack_event.team)
  end

end
