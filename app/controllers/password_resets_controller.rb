class PasswordResetsController < ApplicationController
  
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]  
  before_filer :require_no_user
  
  def new
    render
  end
  
  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = "Instructions to reset your account have been emaild to you. " +
      "Please check your email"
      redirect_to root_url
    else
      flash[:notice] = "No user was found with that email address"
      render :action => new
    end
  end
  
  def edit
    render
  end
  
  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = "Password succesefully updated"
      redirect_to account_url
    else
      render :action =>:edit
    end
  end
  
  private
    def load_user_using_perishable_token
      @user = User.find_using_perishable_token(params[:id])
      unless @user
        flash[:notice] = "We are sorry, but we could not locate your account. " +
        "If you are having issues try coping and pasting the URL" +
        "from your email into your browser or restarting the " +
        "reset password process."
        redirect_to root_url
      end
    end   
end