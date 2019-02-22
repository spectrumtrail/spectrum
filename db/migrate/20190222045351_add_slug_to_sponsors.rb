class AddSlugToSponsors < ActiveRecord::Migration[5.2]
  def change
    add_column :sponsors, :slug, :string, unique: true
  end
end
