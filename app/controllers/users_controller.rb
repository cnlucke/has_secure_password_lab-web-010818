class UsersController < ApplicationController
  def new
    #goes to signup form
  end

  def create ##create new users
    if user_params[:password].nil? || user_params[:password] == ""
      flash[:notice] = "Password cannot be blank"
      redirect_to signup_path
    elsif (user_params[:password] != user_params[:password_confirmation]) && !user_params[:password_confirmation].nil? ##if they don't match, and pc is not nil
      flash[:notice] = "Password and confirmation must match"
      redirect_to signup_path
    else
      @user = User.create(user_params)
      session[:user_id] = @user.id
      redirect_to :welcome
    end
  end

  def welcome ##goes to user homepage
    @user = User.find_by(id: session[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
