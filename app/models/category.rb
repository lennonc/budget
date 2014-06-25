class Category < ActiveRecord::Base
  has_many :transactions
  has_many :proposed_budgets
end
