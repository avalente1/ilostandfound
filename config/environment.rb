# Load the Rails application.
require File.expand_path('../application', __FILE__)


# Initialize the Rails application.
Ilostandfound::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => 'paay',
  :password => '!@#paay$%^',
  :domain => 'paay.co',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

