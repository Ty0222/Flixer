class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :name
      t.integer :stars
      t.text :comment
      t.string :location
      t.string :movie_slug, index: true

      t.timestamps
    end
  end
end
