class MicropostsController < ApplicationController
  
  before_filter :require_user
  before_filter {set_up('account')}
  
  def new
  end
  
  # Creates and saves a new micropost
  def create
    @micropost = micropost.new(:user_id =>current_user, :content =>"kolkol", :event_id =>12)
    if @micropost.save
      flash[:success] = "Micropost saved!"
    else
      flash[:notice] ="Micropost not saved"
    end
  end
  
  def destroy
    
  end
  
end