class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user_session, :current_user
  before_filter :get_events_and_categories
  before_filter :set_locale

  #Kind of coming soon page
  #before_filter :coming_soon
  
  
  #def change_locale
  #  if current_user
  #    current_user.locale = params[:locale]
  #    current_user.save
  #  else
  #    I18n.locale = params[:locale]
  #  end
  #  redirect_to url_for(locale: locale)
  #end
  
  # Defines the variable for the menu tab
  def set_up(page)
    @page_id = page  
  end
  
  def leftbar_on
    @leftbar_switch = true
  end
  
  def leftbar_off
    @leftbar_switch = false
  end
  
  # Sets the language selected by the user and saves into its profile if logged in
  def set_locale  
    I18n.locale = params[:locale] || I18n.default_locale
    if current_user
      current_user.locale = params[:locale] 
      current_user.save
    end
  end
  
  private
    # Creates a micrpopost
    def create_micropost
      @micropost = Micropost.create(:user_id =>@user.id, :content =>@content, :object_id =>@object)
    end
    
    # Feeds the left_bar
    def get_events_and_categories
      x = rand()
      if x < 0.2
        @lb_title = 'suggestions'
        @events_leftbar = if current_user
        categories = current_user.events.map(&:categories).flatten
          categories.map(&:events).flatten - current_user.events
        else
          Event.limit(8)
        end
      elsif x<0.4
        @lb_title = 'lastest'
        @events_leftbar = Event.order('created_at DESC').limit(8)
      elsif x<0.6
        @lb_title = 'most viewed'
        @events_leftbar =Event.order('views DESC').limit(8)
      elsif x<0.8
        @lb_title = 'most followed'
        @events_leftbar=Event.limit(8)
      else
        @lb_title = 'recomendations'
        @events_leftbar = if current_user
        Event.where(:town => current_user.town).limit(8)
        else
          Event.limit(8)
        end
      end
      if @events_leftbar.empty?
        @events_leftbar =Event.limit(8)
      end
      @categories = Category.all
    end
     
    # Returns the current session 
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    # Return the current user
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
    # Checks whether the user is logged in
    def require_user
      unless current_user
        store_location
        flash[:notice] = I18n.t(:app_require_user)
        redirect_to new_user_sessions_url
        return false
      end
    end
    
    # Return current user into @user variable
    def get_current_user
      @user = current_user
    end
    
    # Checks whether current user is not logged in
    def require_no_user
      if current_user
        redirect_to root_path, :alert => "You must be signed out for that action."
      end
    end
    
    # Store user's requested url  
    def store_location
      session[:return_to] = request.url
    end

    # Redirect to user's requested url or default if nil
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    # Checks whether the user is the creator of an event
    def require_ownership
      @event = Event.find(params[:id])
      unless current_user.id == @event.user.id
        flash[:notice] = I18n.t(:app_require_ownership)
        redirect_to new_user_sessions_url
        return false
      end
    end
    
    
    # Sets default url
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
