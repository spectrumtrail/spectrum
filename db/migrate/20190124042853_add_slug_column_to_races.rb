class AddSlugColumnToRaces < ActiveRecord::Migration[5.2]
  def change
    add_column :races, :slug, :string
    add_index :races, :slug, unique: true
  end
end
