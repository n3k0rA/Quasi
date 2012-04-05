class AlarmsController < ApplicationController
  
  
  def create
    @alarm = Alarms.new(params[:alarm])
    @alarm.user = current_user
    
    respond_to do |format|
      if @alarm.save
        format.html { redirect_to user_alarms_path, notice: "Alarms saved succesfully" }
        format.json { render json: user_alarms_path, status: :created, location: user_alarms_path}
      else
        format.html { redirect_to user_alarms_path, notice: "Impossible to save. Check the form" }
        format.json { render json: @alarm.errors, status: :inprocessable_entity }
      end
    end
  end
  
  def edit
  end
  
  def update
  
  end
  
  def index
    @alarms = current_user.alarms.all
  end
  
  def switch
    @alarm = Alarm.find(params[:id])
    if @alarm.active
      @alarm.active = false
    else
      @alarm.active = true
    end
    @alarm.save
    @event = Event.find(10)
    EventNotifier.alarm(@event, current_user).deliver
    redirect_to alarms_path
  end
  
end