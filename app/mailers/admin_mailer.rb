class AdminMailer < ActionMailer::Base
  default from: "approvals@hikultura.com"

  # Acknowledges the admin of a new evet to be approved
  def approve_event(event)
    @event = event
    
    mail(:to => "admin@hikultura.com", :subject => "Event pending of approval")
  end
  
  #Ackowledges the admin of a flagged comment
  def report_spam(comment)
    @comment = comment
    
    mail(:to =>"admin@hikultura.com", :subject => "Inappropiate content report")
  end
end
