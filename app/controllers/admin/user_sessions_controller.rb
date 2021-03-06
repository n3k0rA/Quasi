class Admin::UserSessionsController < Admin::AdminController
  
  skip_before_filter :require_admin
  
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_back_or_default(account_url)
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to root_url
  end
end