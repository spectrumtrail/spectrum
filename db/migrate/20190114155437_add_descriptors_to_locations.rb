class AddDescriptorsToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :short_description, :string
    add_column :locations, :long_description, :text
    add_column :locations, :website_link, :text
  end
end
