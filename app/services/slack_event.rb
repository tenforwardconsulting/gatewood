class SlackEvent
  def initialize(json)
    @json = json
  end

  def team_id
    @json["team"]
  end

  def channel
    @json["channel"]
  end

  def team
    Team.slack.where(service_id: team_id).first
  end

  def user_id
    @json["user"]
  end

  def ts
    @json["ts"]
  end

  def text
    if @json["type"] == "app_mention"
      @json["text"].gsub /^<@.*>\s+/, ""
    else
      @json["text"]
    end

  end
end
