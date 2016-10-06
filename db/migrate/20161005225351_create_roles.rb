class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :character_name
      t.references :movie
      t.references :actor

      t.timestamps null: false
    end
  end
end
