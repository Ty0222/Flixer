class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :movie_slug, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
