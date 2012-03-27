class Admin::AdminController < Admin::ApplicationController
  
  before_filter :require_admin
  
  
  private 
  
  def require_admin
    unless current_user && current_user.admin?
      store_location
      flash[:notice] = "You must be logged in as an admin to access this page"
      redirect_to new_admin_user_sessions_url
      return false
    end
  end
  
end