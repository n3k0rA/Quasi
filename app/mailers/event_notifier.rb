class EventNotifier < ActionMailer::Base
  
  
  # Notifies the user of the fact that an alarm went off
  def alarm(event, user)
    @event = event
    @user = user
    mail(to: user.email, subject: "\"#{user.name}\" One of you alarms just went off", from: "\"Event Alarm | HiKultura\"<info@hikultura.com>")
  end
  
  # Notifies all the users interested in an event that this is happening in less than 72 hours
  def reminder(event)
    @event = event
    @bcc = @event.users.map(&:email)
    mail(subject: "\"#{@event.title}\" is coming up! Don't miss it!", bcc: @bcc, from: "\"Event Reminder | HiKultura\"<info@hikultura.com>")
  end
  
  # Notifies all the users interested in an event that this has been cancelled
  def cancellation(event)
    @event = event
    @bcc = @event.users.map(&:email)
    mail(subject: "\"#{@event.title}\" has been cancelled", bcc: @bcc, from: "\"Event Cancelation | HiKultura\"<info@hikultura.com>")
  end
end
