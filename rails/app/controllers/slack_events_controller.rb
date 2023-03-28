class SlackEventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  wrap_parameters false

  before_action :verify_slack_request

  def event
    if params[:type] == "url_verification"
      pp @slack_request
      render plain: params[:challenge]
    elsif params[:type] == "event_callback"
      SlackEventProcessor.new(params).process
      head :ok
    end
  end

  private
  def verify_slack_request
    @slack_request = Slack::Events::Request.new(request)
    @slack_request.verify!
  end

end
