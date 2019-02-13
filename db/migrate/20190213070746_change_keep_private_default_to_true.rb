class ChangeKeepPrivateDefaultToTrue < ActiveRecord::Migration[5.2]
  def change
    change_column_default :registrations, :keep_private, true
  end
end
