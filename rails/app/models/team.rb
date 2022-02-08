class Team < ApplicationRecord
  scope :basecamp, -> { where(service: "basecamp") }
  scope :slack, -> { where(service: "slack") }
end
