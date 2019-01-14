class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :gps_lat
      t.string :gps_long
      t.string :address_text
      t.string :address_link
      t.boolean :allows_dogs
      t.string :spectator_entry_fee_text
      t.boolean :is_active

      t.timestamps
    end
  end
end
