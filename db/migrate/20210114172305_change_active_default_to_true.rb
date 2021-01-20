class ChangeActiveDefaultToTrue < ActiveRecord::Migration[5.2]
  def change
    change_column_default :volunteers, :active, from: nil, to: true
  end
end
