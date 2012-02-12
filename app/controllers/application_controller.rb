class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  helper_method :creator
  helper_method :user_is_logged_in?

    private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
    private
    def creator
      @creator ||= User.find(@event.created_by)
    end
    
    def user_is_logged_in?
        !!session[:user_id]
    end
    
      
end
