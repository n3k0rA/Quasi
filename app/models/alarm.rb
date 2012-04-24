class Alarm < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :categories


  def find_alarm
    @event = Event.find(params[event_id])
    
    @alarms = Alarm.where((["CAST(town as varchar(255)) LIKE ?", where]))
    
    #Alarms.each do |alarm|
      
   # @events = Event.where((["CAST(town as varchar(255)) LIKE ?", "%#{params[:search_where]}%"]))
    #@events = @events.where((["CAST(title_es as varchar(255)) LIKE ?", "%#{params[:query]}%"] && ["CAST(title_en as varchar(255)) LIKE ?", "%#{params[:query]}%"] && ["CAST(title_eu as varchar(255)) LIKE ?", "%#{params[:query]}%"] && ["CAST(title_fr as varchar(255)) LIKE ?", "%#{params[:query]}%"]) )

   # @time = Time.new(params[:search_start_date][:year], params[:search_start_date][:month],params[:search_start_date][:day] , params[:search_start_date][:hour], params[:search_start_date][:minute])
   # @events = @events.where("start_date >= ?", @time)
    
    #titles and place done
    
    #categories = params[:category_ids].map(&:to_i) rescue []
   # @events = @events.select do |event| 
   #   categories.size == event.category_ids.size
   # end
   # @events = @events.select do |event| 
   #   categories.all?{|c| event.category_ids.include? c }
   # end
  end
  
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