class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.string :stripe_charge_id
      t.string :stripe_customer_id
      t.integer :amount_charged_in_cents

      t.timestamps
    end
  end
end
