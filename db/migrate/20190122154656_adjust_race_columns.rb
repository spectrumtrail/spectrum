class AdjustRaceColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :races, :distance, :integer
    remove_column :races, :distance_type, :string
    rename_column :races, :course_map_link, :strava_segment_link
    rename_column :races, :course_map_embed_code, :strava_embed_code
    rename_column :races, :long_description, :overview_html
    add_column :races, :registrations_count, :integer, default: 0
    add_column :races, :registrations_limit, :integer, default: 100
  end
end
