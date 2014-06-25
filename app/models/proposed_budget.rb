class ProposedBudget < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  scope :budgeted_spending, -> {where(budget_type: 'spending')}
  scope :budgeted_income, -> {where(budget_type: 'income')}

  def self.left_over
    budgeted_income.sum(:amount) - budgeted_spending.sum(:amount)
  end

end
