module TrendsHelper
  def last_month_net_income
    current_user
  end

  def current_month_income(transactions)
    sum_array = []
    sum_array << transactions.sum(:amount).to_f
  end

  def current_month_expenses(transactions)
    sum_array = []
    sum_array << -transactions.sum(:amount).to_f
  end

  def last_six_months_net_income

  end

  def last_year_net_income

  end


  def months_of_data(num)
    months_array = []
    (0..num).each do |month|
      months_array << raw((Date.today.months_ago(month)).strftime("%b %Y"))
    end
    months_array.reverse!
  end

end