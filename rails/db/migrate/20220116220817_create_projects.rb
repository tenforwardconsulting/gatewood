class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :basecamp_bucket_id
      t.string :basecamp_todolist_id
      t.string :slack_channel_id
      t.timestamps
    end
  end
end
