class PasswordResetsController < ApplicationController
  
  before_filter {set_up('account')}
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]  
  before_filter :require_no_user
  before_filter :leftbar_on
  
  def new
    render
  end
  
  # Creates a new instance of password_reset for an existing user
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
  
  # Updates user's password with the new one
  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      @user.attempts = 0
      @user.save
      flash[:notice] = "Password succesefully updated"
      redirect_to account_url
    else
      render :action =>:edit
    end
  end
  
  private
    # Checks whether the user that wants to reset the password is accessing from the url emailed to him/her
    def load_user_using_perishable_token
      @user = User.find_using_perishable_token(params[:id])
      flash[:notice] = :id
      unless @user
        #flash[:notice] = "We are sorry, but we could not locate your account. " +
        #{}"If you are having issues try coping and pasting the URL" +
        #{}"from your email into your browser or restarting the " +
        #{}"reset password process."
        redirect_to root_url
      end
    end   
end
