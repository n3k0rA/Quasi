class TranslationsMailer < ActionMailer::Base
  default from: "no-reply@hikultura.com"
  
  # Notifies a event's creator of a pending translation
  def approve_translation(translation)
    @translation =translation
    
    if @translation.user.locale == "es"
      @title = @translation.event.title_es
    elsif @translation.user.locale == "eu"
      @title = @translation.event.title_eu
    elsif @translation.user.locale == "en"
      @title = @translation.event.title_es
    elsif @translation.user.locale == "fr"
      @title = @translation.event.title_fr
    
    mail to: @translation.event.user.email, subject: "Translation pending to be approved"
  end
    
    
end
