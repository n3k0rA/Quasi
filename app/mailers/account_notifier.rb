class AccountNotifier < ActionMailer::Base
  default from: "admin@hikultura.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.account_notifier.confirm.subject
  #
  def confirm
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.account_notifier.forgotten.subject
  #
  def forgotten
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
