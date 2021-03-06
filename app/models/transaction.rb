class Transaction < ActiveRecord::Base
  validates_presence_of :date_of_transaction, :description, :amount, :category
  validate :date_is_not_in_future
  validates_numericality_of :amount, :greater_than_or_equal_to => 0


  # before_save :check_transaction_type
  belongs_to :category
  belongs_to :user

  scope :expenses, -> {where(transaction_type: 'expense')}
  scope :income, -> {where(transaction_type: 'income')}

  def self.search(search, user_id)
    if search
      where('description LIKE ? AND user_id = ?', "%#{search}%", "#{user_id}")
    else
      scoped
    end
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
