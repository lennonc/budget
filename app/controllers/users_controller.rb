class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    ap params[:user]
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url
      session[:user_id] = @user.id
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end