class UserSessionsController < ApplicationController
  
  #before_filter :coming_soon, :except => [:new, :create]
  before_filter {set_up('account')}
  before_filter :leftbar_on
  before_filter :get_events_and_categories
  
  # Creates a new instance of user session / Log in
  def new
    @user_session = UserSession.new
  end

  # Creates a saves an user session / Logged in
  def create
    
    @user_session = UserSession.new(params[:user_session])
    @user = User.find_by_email(@user_session.email)
    if !@user.eql?(nil)
      if @user.attempts >= 10
        redirect_to account_locked_path(:id =>@user.id)
      else
        if @user_session.save
          @user.attempts = 0
          redirect_back_or_default(account_url)
        else
          @user.attempts += 1
          render :action => :new
        end
        @user.save
      end
    else
      flash[:notice] = I18n.t(:logging_form_error)
      render :action => :new
    end
  end

  # Deletes an user session / Log out
  def destroy
    current_user_session.destroy
    redirect_to root_url
  end
  

end