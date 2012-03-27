class ReminderController < ApplicationController
  
  
  
  def add
    event = Event.find(params[:id])
    if current_user 
  		event.users << current_user
    	redirect_to event, :notice => I18n.t(:reminders_add)
    else
      redirect_to sign_up_url, :notice => I18n.t(:remindes_add_else)
  	end
  end
  
  def delete
    event = Event.find(params[:id])
    @user = current_user
    event.users.delete(@user) 
  	redirect_to rem_path(:id => current_user.id), :notice => I18n.t(:reminders_delete)
  end
  
end