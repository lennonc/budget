module TransactionsHelper
  def transactions_per_page_link(num)
    url_for :per_page => num.to_s
  end

  def format_transaction_date(date)
    if date > 1.year.ago
      return date.strftime("%b %e")
    else
      date
    end

  end
end
