class AddShortDescriptionToSponsors < ActiveRecord::Migration[5.2]
  def change
    add_column :sponsors, :short_description, :string
  end
end
