class UpdateLocationColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :locations, :website_link, :text
    add_column :locations, :external_website_link, :string
    rename_column :locations, :long_description, :description_html
    remove_column :locations, :allows_dogs, :boolean
  end
end
