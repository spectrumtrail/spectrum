class CreateSeries < ActiveRecord::Migration[5.2]
  def change
    create_table :series do |t|
      t.string :slug
      t.string :name
      t.string :short_description
      t.text :overview_html

      t.timestamps
    end
  end
end
