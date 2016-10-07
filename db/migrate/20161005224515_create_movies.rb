class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :synopsis
      t.datetime :release_date
      t.string :movie_poster_url
      # t.string :genres

      t.timestamps null: false
    end
  end
end
