class FollowersController < ApplicationController
  
  
  def add
    if current_user
      @user.followers << current_user
      redirect_to @user, :notice => "Yeah! Let's follow the user"
    else 
      redirect_to sign_up_url, notice => "Well, you need an account to follow people"
    end
  end
  
end