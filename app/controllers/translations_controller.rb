class TranslationsController < ApplicationController
  before_filter :require_user
  
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
end