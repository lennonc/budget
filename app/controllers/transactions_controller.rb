class TransactionsController < ApplicationController
  before_filter :authorize
  before_action :set_transaction, only: [:edit, :update, :destroy]
  helper_method :transactions_per_page_list

  def transactions_per_page_list
    [10, 20, 50]
  end

  def index
    @per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : transactions_per_page_list.first
    Transaction.per_page = @per_page

    @transactions = current_user.transactions.search(params[:search], current_user.id).paginate(:page => params[:page])
  end

  def new
    @transaction = Transaction.new
    @categories = Category.all
  end

  def create
    @transaction = Transaction.new
    @categories = Category.all

    date_of_transaction = format_date(params)

    @transaction.user_id = current_user.id
    @transaction.date_of_transaction = date_of_transaction
    @transaction.description = params[:transaction][:description]
    @transaction.category_id = params[:transaction][:category_id]
    @transaction.transaction_type = params[:transaction][:transaction_type]
    @transaction.amount = params[:transaction][:amount]

    if @transaction.save
      redirect_to root_path
    else
      @transactions
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def show
  end

  def update
    @categories = Category.all

    update_params = {}
    date_of_transaction = format_date(params)
    update_params[:date_of_transaction] = date_of_transaction
    update_params[:description] = params[:transaction][:description]
    update_params[:category_id] = params[:transaction][:category_id]
    update_params[:transaction_type] = params[:transaction][:transaction_type]

    update_params[:amount] = params[:transaction][:amount]

    if @transaction.update_attributes(update_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if current_user.transactions.include?(@transaction)
      @transaction.destroy
      respond_to do |format|
        format.html { redirect_to transactions_url }
        format.json { head :no_content }
      end
    end
  end

  private
  def set_transaction
    if current_user.transactions.find_by_id(params[:id])
      @transaction = current_user.transactions.find(params[:id])
    else
      nil
    end
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :description, :date_of_transaction, :transaction_type, :category_id)
  end

  def format_date(params)
    date_year = params[:transaction]['date_of_transaction(1i)']
    date_month = params[:transaction]['date_of_transaction(2i)']
    date_day = params[:transaction]['date_of_transaction(3i)']

    Date.strptime "#{date_month}-#{date_day}-#{date_year}", '%m-%d-%Y'
  end
end
