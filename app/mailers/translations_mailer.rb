class TranslationsMailer < ActionMailer::Base
  default from: "no-reply@hikultura.com"
  
  # Notifies a event's creator of a pending translation
  def approve_translation(translation)
    @translation =translation

    
    mail to: @translation.event.user.email, subject: "\"#{@translation.event.title}\" has a pending translation"
  end
    
    
end
