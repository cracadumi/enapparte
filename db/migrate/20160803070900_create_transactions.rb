class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.float :amount
      t.string :status
      t.integer :credit_card_id
      t.integer :user_id
      t.integer :booking_id
      t.text :payment_error

      t.timestamps null: false
    end
  end
end
