class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.date :date_of_transaction
      t.string :description
      t.string :transaction_type
      t.integer :amount

      t.timestamps
    end
  end
end
