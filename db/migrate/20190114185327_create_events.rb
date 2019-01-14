class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :short_description
      t.text :long_description
      t.string :facebook_event_link
      t.string :external_photo_link
      t.string :external_results_link
      t.string :external_reservations_link
      t.string :is_active
      t.datetime :archived_at
      t.string :archived_by

      t.timestamps
    end
  end
end
