class CreateRefunds < ActiveRecord::Migration[5.2]
  def change
    create_table :refunds do |t|
      t.references :payment, foreign_key: true
      t.integer :amount_in_cents
      t.string :admin_reason
      t.string :admin_notes
      t.string :stripe_refund_id

      t.timestamps
    end
  end
end
