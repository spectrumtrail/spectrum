class ChangeExpirationDateDataType < ActiveRecord::Migration[5.2]
  def change
    remove_column :discount_codes, :expiration_date, :string
    add_column :discount_codes, :expiration_date, :datetime
  end
end
