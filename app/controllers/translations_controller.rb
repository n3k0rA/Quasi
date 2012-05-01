class TranslationsController < ApplicationController
  before_filter :require_user
  #before_filter :require_ownership, :only => [:commit]
  after_filter :create_micropost, :only=>[:commit]
  before_filter {set_up('events')}
  before_filter :leftbar_on
  
  # Creates a new instance of tranlation
  def new
    @event = Event.find(params[:id])
    @translation = Translation.new(params[:event_id => @event.id])
  end
  
  # Creates and saves a translation
  def create
    #@event = Event.find(params[:id])
    @translation = Translation.new(params[:translation].merge(:user_id=>current_user.id))
    
    respond_to do |format|
      if @translation.save
        TranslationsMailer.approve_translation(@translation).deliver
        format.html { redirect_to @translation.event, notice: I18n.t(:greeting_user) }
        format.json { render json: @translation.event, status: :created, location: @translation.event }
      else
        format.html { render action: "new" }
        format.json { render json: @translation.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # Displays a translation
  def show
    @translation = Translation.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
  # Deletes an exiting translation
  def destroy
    @translation.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :ok }
    end
  end
  
  # Commit an uploaded translation to the original event
  def commit
    @translation = Translation.find(params[:id])
    @event = @translation.event
    if !@translation.des_es.empty?
      @event.title_es = @translation.title_es
      @event.des_es = @translation.des_es
    end
    if !@translation.des_eu.empty?
      @event.title_eu = @translation.title_eu
      @event.des_eu = @translation.des_eu
    end
    if !@translation.des_fr.empty?
      @event.title_fr = @translation.title_fr
      @event.des_fr = @translation.des_fr
    end
    if !@translation.des_en.empty?
      @event.title_fr = @translation.title_fr
      @event.des_en = @translation.des_en
    end
    @event.save
    @user= @translation.user
    @content = "added_translation"
    @object = @event.id
    redirect_to @event
  end
    
end