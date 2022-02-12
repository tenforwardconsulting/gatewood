class Team < ApplicationRecord
  scope :basecamp, -> { where(service: "basecamp") }
  scope :slack, -> { where(service: "slack") }

  module Service
    BASECAMP = "basecamp"
    SLACK = "slack"
  end

  def self.service_options
    Service.constants.map {|c| [c.to_s.titlecase, Service.const_get(c)] }
  end

  def basecamp?
    service == Service::BASECAMP
  end

  def slack?
    service == Service::SLACK
  end
end
