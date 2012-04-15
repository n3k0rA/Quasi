class TranslationsMailer < ActionMailer::Base
  default from: "no-reply@hikultura.com"
  
  # Notifies a event's creator of a pending translation
  def approve_translation(translation)
    @event = translation.event
    @creator = translation.event.user
    @translator = translation.user
    @comment =translation.comment
    
    mail to: @creator, subject: "\"#{@event.title}\" has a pending translation"
  end
    
    
end
