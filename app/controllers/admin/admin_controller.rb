class Admin::AdminController < ApplicationController
  def new
  end
  
  def create
    user = User.authenticate_admin(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to main_app.root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to main_app.root_url, :notice => "Logged out!"
  end
end