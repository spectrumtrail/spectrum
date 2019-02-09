class AddRefundPolicyHtmlToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :refund_policy_html, :text
  end
end
