class TranslationsController < ApplicationController
  #before_filter :require_user
  #before_filter :require_ownership, :only => [:commit]
  
  def new
    @event = Event.find(params[:id])
    @translation = Translation.new(params[:event_id => @event.id])
  end
  
  def create
    #@event = Event.find(params[:id])
    @translation = Translation.new(params[:translation].merge(:user_id=>current_user.id))
    
    respond_to do |format|
      if @translation.save
        format.html { redirect_to root_url, notice: I18n.t(:users_create) }
        format.json { render json: @user, status: :created, location: @user }
        
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def show
    @translation = Translation.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
  def destroy
    @translation.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :ok }
    end
  end
  
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
    redirect_to @event
  end
    
end