class TranslationsMailer < ActionMailer::Base
  default from: "no-reply@hikultura.com"
  
  def approve_translation(translation)
    @event = translation.event
    @creator = translation.event.user
    @translator = translation.user
    
    
end
