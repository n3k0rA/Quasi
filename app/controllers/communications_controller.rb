class CommunicationsController < ApplicationController
  
  before_filter :require_user
  
  def create
    @communication =current_user.communications.build(:receiver_id =>params[:receiver_id])
    if @communiation.save
      redirect_to root_url
    else
      flash[:notice] = "Unable to send your message"
      redirect_to rool_url
    end
  end
  
  def destroy
  end
  
  def show
  end
  
  
end
