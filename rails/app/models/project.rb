class Project < ApplicationRecord
  belongs_to :slack_team, class_name: "Team", optional: true
  belongs_to :basecamp_team, class_name: "Team"

  def basecamp_client
    @basecamp_client ||= BasecampClient.new(basecamp_team, self)
  end

  def basecamp_bucket_display
    if basecamp_bucket_id
      basecamp_client.project["name"]
    else
      "No Bucket connected"
    end
  end

  def basecamp_todolist_display
    if basecamp_todolist_id
      basecamp_client.todolist(basecamp_todolist_id)["name"]
    else
      "No Todolist connected"
    end
  end
end
