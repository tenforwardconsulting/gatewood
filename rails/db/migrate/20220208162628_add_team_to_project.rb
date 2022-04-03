class AddTeamToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :slack_team_id, :int
    add_column :projects, :basecamp_team_id, :int
  end
end
