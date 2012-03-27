# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Quasi::Application.initialize!

# Initialize mail delivery
Depot::Application.configure do
  config.action_mailer.delivery_method = :smtp
  
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "hikultura.com"
    authentication: "plain"
    user_name: "info"
    password: "kotxo52683"
    enable_starttls_auto: true
  }
end