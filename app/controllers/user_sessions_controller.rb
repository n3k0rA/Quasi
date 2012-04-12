class UserSessionsController < ApplicationController
  
  #before_filter :coming_soon, :except => [:new, :create]
  before_filter {set_up('account')}
  
  def new
    @user_session = UserSession.new
  end

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

  def destroy
    current_user_session.destroy
    redirect_to root_url
  end
  

end