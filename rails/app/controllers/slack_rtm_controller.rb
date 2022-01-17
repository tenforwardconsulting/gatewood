class SlackRtmController < ApplicationController
  before_action :authenticate
  skip_before_action :verify_authenticity_token


  def receive
    if params[:text] =~ /.*\!todo\s+(.*)?/
      command = CommandParser.parse($1)
      if command.due.nil?
        render json: {reply: "Oh no, you know it won't get done without a due date!"}
      else
        render json: {reply: "Ok, I'll make sure you '#{command.text}' by #{command.due_display}"}
      end
    else
      render json: {reply: "Sorry hon, I didn't get that."}
    end
  end

  private
  def authenticate
    true
  end
end