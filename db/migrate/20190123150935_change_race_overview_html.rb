class ChangeRaceOverviewHtml < ActiveRecord::Migration[5.2]
  def up
    change_column :races, :overview_html, :text
  end

  def down
    change_column :races, :overview_html, :string
  end
end
