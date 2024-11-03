class CreateSubscription < ActiveRecord::Migration[7.2]
  def change
    create_table :subscriptions do |t|
      t.integer :status, null: false, default: 0
      t.decimal :balance, precision: 36, scale: 18
      t.decimal :remaining_amount, precision: 36, scale: 18
      t.integer :retry_attempts, null: false, default: 0
      t.date :next_pay_at

      t.timestamps
    end
  end
end
