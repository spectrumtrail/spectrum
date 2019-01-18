class RestructureEventDataColumns < ActiveRecord::Migration[5.2]
  def change
    # these will be html inputs
    rename_column :events, :long_description, :overview_html
    add_column :events, :schedule_html, :text
    add_column :events, :details_html, :text
    add_column :events, :course_html, :text

    # these will be delegated to Races
    remove_column :events, :external_reservations_link, :string
    remove_column :events, :external_photo_link, :string
    remove_column :events, :external_results_link, :string

    # this is irrelevant for events
    remove_column :events, :external_results_link, :string
  end
end
