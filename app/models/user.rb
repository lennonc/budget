class User < ActiveRecord::Base
  attr_accessor :password

  validates_presence_of     :first_name, :last_name, :email
  validates_presence_of     :password, :on => :create
  validates_uniqueness_of   :email
  validates_confirmation_of :password


  before_save :encrypt_password

  has_many :transactions

  def total_expenses
    self.transactions.expenses.sum(:amount)
  end

  def total_income
    self.transactions.income.sum(:amount)
  end

  def net_income
    self.transactions.income.sum(:amount) - self.transactions.expenses.sum(:amount)
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    if password.present?
      if user && user.password_digest && user.password_digest == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
      else
        nil
      end
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt    = BCrypt::Engine.generate_salt
      self.password_digest  = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def name
    self.first_name + " " + self.last_name
  end
end
