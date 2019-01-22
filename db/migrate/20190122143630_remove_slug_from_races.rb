class RemoveSlugFromRaces < ActiveRecord::Migration[5.2]
  def change
    remove_column :races, :slug, :string
  end
end
