class Project < ApplicationRecord
  belongs_to :slack_team, class_name: "Team", optional: true
  belongs_to :basecamp_team, class_name: "Team"
end
