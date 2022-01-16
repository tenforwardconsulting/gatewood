class SlackRtmController < ApplicationController
  before_action :authenticate
  skip_before_action :verify_authenticity_token


  def receive
    if params[:text] =~ /.*\!todo\s+(.*)?/
      command = CommandParser.parse($1)
      render json: {reply: "Ok, I'll make sure you '#{command.text}' by #{command.due_display}"}
    else
      render json: {reply: "Sorry hon, I didn't get that."}
    end
  end

  private
  def authenticate
    true
  end
end