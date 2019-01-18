class AddSlugToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :slug, :string
    add_index :locations, :slug, unique: true
  end
end
