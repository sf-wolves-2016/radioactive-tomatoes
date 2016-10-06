class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :name
      t.datetime :dob
      t.text :bio
      t.string :headshot_url

      t.timestamps null: false
    end
  end
end
