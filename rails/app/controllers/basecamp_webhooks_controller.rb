# https://github.com/basecamp/bc3-api/blob/master/sections/webhooks.md#webhooks
class BasecampWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def event
    pp params
    BasecampEventProcessor.new(params).process

    head :ok
  end
end