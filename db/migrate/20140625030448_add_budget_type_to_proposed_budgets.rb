class AddBudgetTypeToProposedBudgets < ActiveRecord::Migration
  def change
    add_column :proposed_budgets, :budget_type, :string
  end
end
