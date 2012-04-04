class AdminMailer < ActionMailer::Base
  default from: "approvals@hikultura.com"

  
  def approve_event(event)
    @event = event
    
    mail(:to => "admin@hikultura.com", :subject => "Event pending of approval")
  end
end
