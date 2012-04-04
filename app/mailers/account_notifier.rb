class AccountNotifier < ActionMailer::Base
  default from: "admin@hikultura.com"
  

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.account_notifier.confirm.subject
  #
  def confirm(user)
    @greeting = "Hi"
    @user = user

    mail to: user.email, subject: 'Welcome to Hikultura! Please confirm account.'
  end



  def password_reset_instructions(user)
    @user = user
    #default_url_options[:host] = "authlogic_example.binarylogic.com"
    mail to: user.email, subject: 'Password reset for HiKultura'
    
    
  end 
end