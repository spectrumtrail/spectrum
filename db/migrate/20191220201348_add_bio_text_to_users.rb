class AddBioTextToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bio_text, :text
  end
end
