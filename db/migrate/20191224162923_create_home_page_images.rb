class CreateHomePageImages < ActiveRecord::Migration[5.2]
  def change
    create_table :home_page_images do |t|
      t.string :short_name
      t.integer :display_order
      t.boolean :hidden, default: false

      t.timestamps
    end
  end
end
