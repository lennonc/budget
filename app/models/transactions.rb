class Transactions < ActiveRecord::Base
  validates_presence_of :date_of_transaction, :description, :amount, :category
  validate :date_is_not_in_future
  validates_numericality_of :amount

  # before_save :check_transaction_type
  belongs_to :category
  scope :expenses, -> {where(transaction_type: 'expense')}
  scope :income, -> {where(transaction_type: 'income')}

  def self.total_expenses
    Transactions.expenses.sum(:amount)
  end

  def self.total_income
    Transactions.income.sum(:amount)
  end

  private
  def date_is_not_in_future
    if self.date_of_transaction > Time.now
      self.errors[:date_of_transaction] << "Date must not be in the future."
      false
    else
      true
    end
  end
end
