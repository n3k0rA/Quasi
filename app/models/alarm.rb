class Alarm < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :categories


  
  def self.proba
    @event = Event.find(31)
    @user =User.find(12)
    EventNotifier.alarm(@event, @user).deliver
  end
  
  def self.proba2
    @event = Event.find(30)
    @user =User.find(13)
    EventNotifier.alarm(@event, @user).deliver
  end
end