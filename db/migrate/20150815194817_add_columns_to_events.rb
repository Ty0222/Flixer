class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :description, :text,
    add_column :events, :released_on, :date
  end
end
