class AddExternalResultsLinkToRaces < ActiveRecord::Migration[5.2]
  def change
    add_column :races, :external_results_link, :string
  end
end
