class UsersController < ApplicationController

  before_filter {set_up('account')}
  before_filter :require_user, :only =>[:edit, :update, :destroy, :reminders, :messages, :events, :microposts, :profile]
  before_filter :get_current_user, :only => [:edit, :update, :destroy, :reminders, :events, :messages, :microposts, :profile]
  before_filter :leftbar_on
  
  # Gets all the users interested in an event
  def index
    @event = Event.find(params[:id])
    @users = @event.users
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end


  # Shows the public view of a user profile
  def show
    @user = User.find(params[:id])
    @followers = Following.where(:followed_id => @user).all
    meta :title => @user.name
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end


  # Creates a new instance of user
  def new
    @user = User.new
  end

  # Edits an existing suer
  def edit
  end


  # Creates and saves a new user
  def create
    @user = User.new(params[:user])
    @user.locale = I18n.locale
    AccountNotifier.confirm(@user).deliver
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, notice: I18n.t(:users_create) }
        format.json { render json: @user, status: :created, location: @user }
        
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # Updates an existing user's parameters after being edited
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: I18n.t(:users_update) }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # Deletes a user from the database
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :ok }
    end
  end
  
  # Displays the reminders of a user
  def reminders
  @events = @user.events.where('finishDate >= ?', Time.now).paginate(:page => params[:page])
    #@events = @even.find(:all, :conditions=> ['finishDate >= ?', Time.now])
  #@events = @user.events.paginate(:page =>params[:page])
  end
  
  # Displays the created events of a user
  def events
    @even = @user.created_events.order('created_at DESC')
    @events = @even.paginate(:page => params[:page])
  end
  
  # Displays the messages of a user
  def messages
  end

  # Displays a use the status of account locked
  def account_locked
    @user = User.find(params[:id])
  end
  
  # Displays the followed's microposts of a user
  def microposts   
    @microposts = Micropost.where(user_id: current_user.followed_ids).order('created_at desc').all
  end
  
  # Displays the private view of a user profile
  def profile
  end
end
