class FollowingsController < ApplicationController
  
  before_filter {set_up('account')}
  before_filter :require_following_ownership, :only => [:destroy]
  before_filter :require_user, :only => [:create, :index]
  after_filter :create_micropost, :only => [:create]
  before_filter :get_current_user, :only=>[:index]
  
  # Creates a saves a new following
  def create
    @following = current_user.followings.build(:followed_id => params[:followed_id])
    @user = current_user
    @object = @following.followed_id
    @content = "following"
    if @following.save
      redirect_to root_path, :notice => I18n.t(:followings_create)
    else
      render :action => 'new'
    end
  end

  # Destroys a following
  def destroy
    @following.destroy
    redirect_to current_user, :notice => I18n.t(:followings_destroy)
  end
  
  private
    # Checks whether the current user is the owner of the following
    def require_following_ownership
      @following = Following.find(params[:id])
      unless current_user.id == @following.user_id
        flash[:notice] = I18n.t(:followings_require_f)
        redirect_to new_user_sessions_url
        return false
    end
  end
  
  def index
  end
end
