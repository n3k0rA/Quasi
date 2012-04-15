class AccountNotifier < ActionMailer::Base
  default from: "admin@hikultura.com"
  


  # Sends a welcoming email to a new registerd user
  def confirm(user)
    @greeting = "Hi"
    @user = user

    mail to: user.email, subject: 'Welcome to Hikultura!'
  end


  # Sends requested intructions to reset password
  def password_reset_instructions(user)
    @user = user
    #default_url_options[:host] = "authlogic_example.binarylogic.com"
    mail to: user.email, subject: 'Password reset for HiKultura'
    
    
  end 
end