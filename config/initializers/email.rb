ActionMailer::Base.smtp_settings = {
  :address => ENV['SMTP_ADDRESS'],
  :port => ENV['SMTP_PORT'],
  :domain => Rails.application.domain,
  :enable_starttls_auto => true,
  :user_name => ENV['SMTP_USERNAME'],
  :password => ENV['SMTP_PASSWORD'],
  :authentication => :login
}
