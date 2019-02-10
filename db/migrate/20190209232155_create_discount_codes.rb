class CreateDiscountCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :discount_codes do |t|
      t.string :code
      t.string :description
      t.string :expiration_date
      t.integer :percent
      t.integer :cents
      t.boolean :check_email
      t.text :valid_emails

      t.timestamps
    end
  end
end
