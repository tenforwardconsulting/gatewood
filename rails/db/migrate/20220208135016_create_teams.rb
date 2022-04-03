class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :service
      t.string :service_id
      t.json :oauth_token

      t.timestamps
    end
  end
end
