class FollowingsController < ApplicationController
  
  before_filter :require_following_ownership, :only => [:destroy]
  before_filter :require_user, :only => [:create]
  
  def create
    @following = current_user.followings.build(:followed_id => params[:followed_id])
    if @following.save
      redirect_to root_path, :notice => I18n.t(:followings_destroy)
      
    else
      render :action => 'new'
    end
  end

  def destroy
    @following.destroy
    redirect_to current_user, :notice => I18n.t(:followings_destroy)
  end
  
  private
    def require_following_ownership
      @following = Following.find(params[:id])
      unless current_user.id == @following.user_id
        flash[:notice] = I18n.t(:followings_require_f)
        redirect_to new_user_sessions_url
        return false
      end
    end
end
