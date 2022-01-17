json.extract! project, :id, :name, :basecamp_bucket_id, :basecamp_todolist_id, :slack_channel_id, :created_at, :updated_at
json.url project_url(project, format: :json)
