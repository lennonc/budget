class TransactionsController < ApplicationController

  helper_method :transactions_per_page_list

  def transactions_per_page_list
    [10, 20, 50]
  end

  def index
    @per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : transactions_per_page_list.first
    Transactions.per_page = @per_page

    @transactions = Transactions.search(params[:search]).paginate(:page => params[:page]) unless @transactions

  end

  def new
    @transaction = Transactions.new
    @categories = Category.all
  end

  def create
    @transaction = Transactions.new
    date_year = params[:transactions]['date_of_transaction(1i)']
    date_month = params[:transactions]['date_of_transaction(2i)']
    date_day = params[:transactions]['date_of_transaction(3i)']
    date_of_transaction = Date.strptime "#{date_month}-#{date_day}-#{date_year}", '%m-%d-%Y'

    @transaction.date_of_transaction = date_of_transaction
    @transaction.description = params[:transactions][:description]
    @transaction.category_id = params[:transactions][:category_id]
    @transaction.transaction_type = params[:transactions][:transaction_type]

    @transaction.amount = params[:transactions][:transaction_type] == 'expense' ? -(params[:transactions][:amount].to_i) : params[:transactions][:amount].to_i

    if @transaction.save
      redirect_to root_path
    else
      @transactions
      render :new
    end
  end

  def edit
    @transaction = Transactions.find(params[:id])
  end

  private
  def transaction_params
    params.require(:transactions).permit(:amount, :description, :date_of_transaction, :transaction_type, :category_id)
  end
end
