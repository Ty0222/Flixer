class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies, id: false do |t|
      t.string :title
      t.string :rating
      t.decimal :total_gross

      t.timestamps
    end
  end
end
