class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :slack_id
      t.string :basecamp_id
      t.timestamps
    end
  end
end
