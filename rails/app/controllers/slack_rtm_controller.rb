class SlackRtmController < ApplicationController
  before_action :authenticate
  skip_before_action :verify_authenticity_token
  wrap_parameters false


  def receive
    if params[:text] =~ /.*\!todo\s+(.*)?/
      @command = CommandParser.parse($1)
      raise "Oww sheesh, I don't know what Basecamp to use in this channel!" unless find_project
      raise "Oh no, you know it won't get done without a due date!" if @command.due_date.nil?

      response = create_todo
      if response.success?
        render json: {reply: "You got it! #{response.parsed_response["app_url"]}"}
      else
        raise "Uh oh :( #{response.code}: #{response.body}"
      end
    else
      raise "Sorry hon, I didn't get that."
    end
  rescue Exception => ex
    render json: { reply: ex.message }
    pp ex
  end

  # TODO need to get the real slack team
  def create_todo
    ts = params[:ts].gsub(".","")
    BasecampClient.new(@project).create_todo(
      text: @command.text,
      due_date: @command.due_date,
      source: "<a href=\"https://#{ENV["SLACK_TEAM"]}.slack.com/archives/#{params[:channel]}/p#{ts}\">Slack</a>"
    )
  end

  def find_project
    @project = Project.where(slack_channel_id: params[:channel]).first
  end

  private
  def authenticate
    true
  end
end