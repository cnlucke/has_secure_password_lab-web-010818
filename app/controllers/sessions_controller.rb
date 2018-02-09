class SessionsController < ApplicationController

  def new
  end

  def create
    #reject nil or empty passwords immediately
    if params[:user][:password].nil? || params[:user][:password] == ""
      flash[:notice] = 'Password cannot be blank'
      redirect_to login_path
    else
      #see if user exists
      user = User.find_by(name: params[:user][:name])
      user = user.try(:authenticate, params[:user][:password])
      return redirect_to '/' unless user
      session[:user_id] = user.id
      @user = user
      redirect_to welcome_path(@user)
    end
  end
end
