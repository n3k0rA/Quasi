class UsersController < ApplicationController

  before_filter {set_up('account')}
  before_filter :require_user, :only =>[:edit, :update, :destroy, :reminders, :messages, :events, :microposts]
  before_filter :get_current_user, :only => [:edit, :update, :destroy, :reminders, :events, :messages, :microposts, :profile]
  
  def index
    @event = Event.find(params[:id])
    @users = @event.users

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @followers = Following.where(:followed_id => @user).all
    meta :title => @user.name
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
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

  # PUT /users/1
  # PUT /users/1.json
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

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :ok }
    end
  end
  
  def reminders
    @events = @user.events.find(:all, :conditions=> ['finishDate >= ?', Time.now])
  end
  
  def events
  end
  
  def messages
  end
  
  
  
  def account_locked
    @user = User.find(params[:id])
  end
  
  def microposts   
    @microposts = Micropost.where(user_id: current_user.followed_ids).order('created_at desc').all
  end
  
  def profile
  end
  

end
