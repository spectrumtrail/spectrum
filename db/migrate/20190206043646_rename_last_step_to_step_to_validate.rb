class RenameLastStepToStepToValidate < ActiveRecord::Migration[5.2]
  def change
    rename_column :registrations, :last_step, :step_to_validate
  end
end
