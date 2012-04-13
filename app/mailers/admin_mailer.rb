class AdminMailer < ActionMailer::Base
  default from: "approvals@hikultura.com"

  
  def approve_event(event)
    @event = event
    
    mail(:to => "admin@hikultura.com", :subject => "Event pending of approval")
  end
  
  def report_spam(comment)
    @comment = comment
    
    mail(:to =>"admin@hikultura.com", :subject => "Inappropiate content report")
  end
end
