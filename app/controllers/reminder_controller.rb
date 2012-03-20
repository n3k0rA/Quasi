class ReminderController < ApplicationController
  
  
  
  def add
    event = Event.find(params[:id])
    if user_is_logged_in? 
  		event.users << current_user
    	redirect_to event, :notice => "Added to your reminders!"
    else
      redirect_to sign_up_url, :notice => "Well, you need an account to add reminders"
  	end
  end
  
  def delete
    event = Event.find(params[:id])
    @user = current_user
    event.users.delete(@user) 
  	redirect_to rem_path(:id => current_user.id), :notice => "Reminder deleted!"
  end
  
end