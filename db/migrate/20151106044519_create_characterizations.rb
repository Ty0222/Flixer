class CreateCharacterizations < ActiveRecord::Migration
  def change
    create_table :characterizations do |t|
      t.string :movie_slug, index: true
      t.references :genre, index: true

      t.timestamps
    end
  end
end
