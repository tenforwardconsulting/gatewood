class BasecampEventProcessor
  def initialize(event_params)
    @event = event_params
  end

  def process
    if project.nil?
      Rails.logger.warn("Received event for unknown project")
      return
    end

    find_action_items.each do |action_item|
      cmd = CommandParser.parse(action_item[:text])
      # TODO #people below only loads 15 people on the project, including archived
      # so it can fail in some circumstances.  Maybe refactor to lookup a person specifically?
      assigned_to = action_item[:mentions].map do |mention|
        basecamp_client.people.find {|p| p["attachable_sgid"] == mention}["id"]
      end
      basecamp_client.create_todo(
        text: cmd.text,
        due_date: cmd.due_date,
        assigned_to: assigned_to,
        source: @event["recording"]["app_url"]
      )
    end
  end

  def project
    @project ||= begin
      Project.where(basecamp_bucket_id: @event["recording"]["bucket"]["id"]).first
    end
  end

  def basecamp_client
    @basecamp_client ||= BasecampClient.new(project)
  end

  # [{
  #   mentions: ["long_sgid"],
  #   text: "do some work tomorrow"
  # }]
  def find_action_items
    html = Nokogiri::HTML(@event["recording"]["content"])

    html.css("h1").each do |h1|
      if h1.text.upcase == "ACTION ITEMS"
        if h1.next.name == "ul"
          return h1.next.css('li').map do |li|
            {
              mentions: li.css("bc-attachment[content-type='application/vnd.basecamp.mention']").map { |a| a.attr('sgid') },
              text: li.text.strip,
            }
          end
        end
      end
    end

    []
  end

  def parse_action_item(item_html)

  end
end