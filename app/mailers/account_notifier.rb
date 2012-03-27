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

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.account_notifier.forgotten.subject
  #
  def forgotten(email)
    @user = User.find(params[:email])
    @greeting = "Hi"

    mail to: @user.email, subject: 'HiKultura has your answers!'
  end
end
