class EventsController < ApplicationController
  
  before_filter :require_user, :only => [:new, :create, :update, :edit]
  before_filter :require_ownership, :only => [:edit, :update, :destroy]
  before_filter :set_up_events, :except =>[:locations, :province]
  before_filter :set_up_locations, :only =>[:locations, :province]
  before_filter :leftbar_on
  before_filter :leftbar_off, :only =>[:index, :category, :province, :locations]
  
  after_filter :create_micropost, :only=>[:update]
  
  
  # Filters events by category
  def category
    @category = Category.find(params[:category])
    @events = @category.events.paginate(:page => params[:page])
    meta :title => @category.name, :description => @category.name
  end
  
  # Display all the events
  def index
    @events = Event.paginate(:page => params[:page])
    #@events = Event.paginate(:page => params[:page], :order=> 'startDate ASC')
    #@events = Event.where('finishDate >= ?', Time.now).order('startDate ASC').paginate(:page => params[:page])
  end


  # Display an event
  def show
    @event = Event.find(params[:id])
    @event.views =+ 1
    @event.save
    @comment = Comment.new(:event => @event)
    @json = @event.to_gmaps4rails
    meta :title => @event.title, :description => @event.description
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end


  # Create a new instane of event
  def new
		@event = Event.new
		
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # Edits an event
  def edit
    @event = Event.find(params[:id])
  end


  # Creates and saves a new event
  def create  
    categories = params[:category_ids] or []
    @event = Event.new(params[:event].merge(:user_id => current_user.id, :category_ids => categories))
    check_date
    respond_to do |format|
      if @event.save
        AdminMailer.approve_event(@event).deliver
        format.html { redirect_to @event, notice: I18n.t(:events_create) }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  # Updates event's parameters after being edited
  def update
    categories = params[:category_ids] or []
    @event = Event.find(params[:id])
    @user = @event.user
    @object = @event.id
    
    if @event.cancelled
      @content = "cancelled"
      @event.approved = true
      respond_to do |format|
        if @event.update_attributes(params[:event].merge(:category_ids => categories))
          format.html { redirect_to events_created_path, notice: I18n.t(:event_deleted) }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
      EventNotifier.cancellation(@event).deliver
    else
      if @event.approved?
        @content = "edited"
      end  
      check_date
      respond_to do |format|
        if @event.update_attributes(params[:event].merge(:category_ids => categories))
          format.html { redirect_to events_created_path, notice: I18n.t(:event_update) }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
  
  end
  
  # Creates a new event with same parameters of an existing one
  def resubmit
    @old_event = Event.find(params[:id])
    @event = Event.new
  end
  
  

  # Deletes an event
  def destroy
    @event = Event.find(params[:id])
    if (@event.users.empty? || (@event.approved =false))
      @event.destroy
      respond_to do |format|
        format.html { redirect_to events_url }
        format.json { head :ok }
      end
    else
      @event.cancelled = true
      @event.approved = false
      @event.save
      redirect_to cancel_event_path(:id=>@event.id)
    end
  end
  
  # Cancels an event
  def cancel
    @event = Event.find(params[:id])
  end
  
  def locations
    @events =Event.paginate(:page => params[:page])
  end
  
  # Filters events by province
  def province
    @province = params[:province]
    @events = Event.where(:province => @province).paginate(:page => params[:page])
  end
  
  # Checks whether a comment has been posted more than 5 min ago
  def deletable_comment
    @comment = Comment.find(params[:id])
    if Time.now > (@comment.created_at + 5.minutes)
      flash[:notice] = "This comment is already in memory system and cannot be deleted"
      redirect_to @comment.event
      return false
    end
  end
  
  # Look for events that need to send reminders to those interested
  def remind_users
    @events = Event.all
    @events.each do |event|
      if (!event.reminded  && close_date)
        EventNotifier.reminder(event).deliver
      end
    end
  end
  
private
  # Set the event to 'reminded'
  def check_date
    if close_date
      @event.reminded = true
    end
  end
  
  # Checks whether an event is happening in less than 72h
  def close_date
    if ((@event.startDate-Time.now)< 259146.01469397545)
      true
    else 
      false
    end
  end
 
  # Sets the variables for the events menu tab
  def set_up_events
    set_up('events')
  end
  
  # Sets the variable for the locations menu tab
  def set_up_locations
    set_up('locations')
  end
  
  
end
