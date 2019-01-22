class AddLodgingHtmlToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :lodging_html, :text
  end
end
