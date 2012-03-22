class FollowingsController < ApplicationController
  
  before_filter :require_ownership, :only => [:destroy]
  before_filter :require_user, :only => [:create]
  
  def create
    @following = current_user.followings.build(:followed_id => params[:followed_id])
    if @following.save
      redirect_to root_url, :notice => "Yeah, now you follow!."
    else
      render :action => 'new'
    end
  end

  def destroy
    @following = current_user.following.find(params[:id])
    @following.destroy
    redirect_to current_user, :notice => "Not following anymore"
  end
end
