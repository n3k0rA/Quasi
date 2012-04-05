class EventNotifier < ActionMailer::Base
  
  
  
  def alarm(event, user)
    @event = event
    @user = user
    
    
    mail(to: user.email, subject: "\"#{user.name}\" One of you alarms just went off", from: "\"Event Alarm | HiKultura\"<info@hikultura.com>")
  end
  
  def reminder(event)
    @event = event
    
  end
end
