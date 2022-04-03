class Team < ApplicationRecord
  scope :basecamp, -> { where(service: "basecamp") }
  scope :slack, -> { where(service: "slack") }

  has_many :slack_projects, class_name: "Project", foreign_key: :slack_team_id
  has_many :basecamp_projects, class_name: "Project", foreign_key: :basecamp_team_id

  module Service
    BASECAMP = "basecamp"
    SLACK = "slack"
  end

  def self.service_options
    Service.constants.map {|c| [c.to_s.titlecase, Service.const_get(c)] }
  end

  def projects
    if slack?
      slack_projects
    elsif basecamp?
      basecamp_projects
    end
  end

  def basecamp?
    service == Service::BASECAMP
  end

  def slack?
    service == Service::SLACK
  end
end
