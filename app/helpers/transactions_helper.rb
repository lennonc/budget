module TransactionsHelper
  def transactions_per_page_link(num)
    url_for :per_page => num.to_s
  end
end
