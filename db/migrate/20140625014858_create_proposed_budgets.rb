class CreateProposedBudgets < ActiveRecord::Migration
  def change
    create_table :proposed_budgets do |t|
      t.datetime :proposed_date
      t.integer :user_id
      t.decimal :amount, :decimal, :precision => 10, :scale => 2
      t.integer :category_id
      t.string :description

      t.timestamps
    end
  end
end
