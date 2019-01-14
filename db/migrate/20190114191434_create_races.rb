class CreateRaces < ActiveRecord::Migration[5.2]
  def change
    create_table :races do |t|
      t.references :event, foreign_key: true
      t.string :name
      t.integer :distance
      t.string :distance_type
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :is_active
      t.datetime :registration_opens_at
      t.datetime :archived_at
      t.string :archived_by
      t.string :course_map_link
      t.text :course_map_embed_code
      t.text :course_description_text
      t.string :short_description
      t.string :long_description
      t.text :video_embed_code

      t.timestamps
    end
  end
end
