ActionMailer::Base.smtp_settings = {
  from:           'moinmoin@grammar-blitz.fun',
  user_name:      'apikey',
  password:       ENV['SENDGRID_API_KEY'],
  domain:         'grammar-blitz.fun',
  address:        "smtp.sendgrid.net",
  port:            587,
  authentication: :plain,
  enable_starttls_auto: true
}
