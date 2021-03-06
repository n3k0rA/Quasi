class Admin::EventsController < Admin::AdminController
  
  after_filter :create_micropost, :only=>[:approved]
  
  def category
    @category = Category.find(params[:category])
    @events = @category.events
  end
  
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @comment = Comment.new(:event => @event)
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

    respond_to do |format|
      if @event.save
        format.html { redirect_to admin_event_path(@event), notice: 'Event was successfully created.' }
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

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to admin_event_path(@event), notice: 'Event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to admin_events_url }
      format.json { head :ok }
    end
  end
  
  def locations
  end
  
  def approved
    @event = Event.find(params[:id])
    @user = @event.user
    @content = "uploaded"
    @object=@event.id
    @event.approved = true
    @event.save
    find_alarm(@event.id)
    flash[:notice] = "Event approved succesfully"
    redirect_to admin_events_path
  end
  
end
