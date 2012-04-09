class EventsController < ApplicationController
  
  before_filter :require_user, :only => [:new, :create, :update, :edit]
  before_filter :require_ownership, :only => [:edit, :update, :destroy]
  after_filter :create_micropost, :only=>[:update]
  def category
    @category = Category.find(params[:category])
    @events = @category.events
  end
  
  # GET /events
  # GET /events.json
  def index
    
    @events = Event.paginate(:page => params[:page])
    
    
  end

  # GET /events/1
  # GET /events/1.json
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

  # GET /events/new
  # GET /events/new.json
  def new
		@event = Event.new
		
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
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

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])
    @user = @event.user
    @object=@event.id
    if @event.cancelled
      @content = "cancelled"
      @event.approved = true
      respond_to do |format|
        if @event.update_attributes(params[:event])
          format.html { redirect_to @event, notice: I18n.t(:event_update) }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
      EventNotifier.cancellation(@event).deliver
    else
      @content = "edited"
      check_date
      respond_to do |format|
        if @event.update_attributes(params[:event])
          format.html { redirect_to @event, notice: I18n.t(:event_update) }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  
  def resubmit
    @old_event = Event.find(params[:id])
    @event = Event.new
  end
  
  
  # DELETE /events/1
  # DELETE /events/1.json
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
  
  def cancel
    @event = Event.find(params[:id])
  end
  
  def locations
  end
  
  def deletable_comment
    @comment = Comment.find(params[:id])
    if Time.now > (@comment.created_at + 5.minutes)
      flash[:notice] = "This comment is already in memory system and cannot be deleted"
      redirect_to @comment.event
      return false
    end
  end
  
  def remind_users
    @events = Event.all
    @events.each do |event|
      if (!event.reminded  && close_date)
        EventNotifier.reminder(event).deliver
      end
    end
  end
  
private
  def check_date
    if close_date
      @event.reminded = true
    end
  end
  
  def close_date
    if ((@event.startDate-Time.now)< 259146.01469397545)
      true
    else 
      false
    end
  end
end
