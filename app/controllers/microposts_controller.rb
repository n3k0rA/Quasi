class MicropostsController < ApplicationController
  
  before_filter :require_user
  
  
  def new
  end
  
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