class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user_session, :current_user
  before_filter :get_events_and_categories
  before_filter :set_locale, :except => [:change_locale]

  #Kind of coming soon page
  before_filter :coming_soon
  
  
  def change_locale
    if current_user
      current_user.locale = params[:locale]
      current_user.save
    else
      I18n.locale = params[:locale]
    end
    redirect_to root_url
  end
  
  private
    def get_events_and_categories
      @events_leftbar = if current_user
        categories = current_user.events.map(&:categories).flatten
        categories.map(&:events).flatten - current_user.events
      else
        Event.all
      end
      @categories = Category.all
    end
      
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = I18n.t(:app_require_user)
        redirect_to new_user_sessions_url
        return false
      end
    end
      
    def store_location
      session[:return_to] = request.url
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def require_ownership
      @event = Event.find(params[:id])
      unless current_user.id == @event.user.id
        flash[:notice] = I18n.t(:app_require_ownership)
        redirect_to new_user_sessions_url
        return false
      end
    end
    
    def set_locale
      if (current_user && !current_user.locale.empty?)
        I18n.locale = current_user.locale
      else
        I18n.locale = params[:locale] || I18n.default_locale
      end
    end
    
    def default_url_options(options={})
      logger.debug "default_url_options is passed options: #{options.inspect}\n"
      { :locale => I18n.locale }
    end
    
    def coming_soon
      unless current_user
        store_location
        flash[:notice] = I18n.t(:app_require_user)
        redirect_to log_in_url
        return false
      end
    end
end
