ActionMailer::Base.smtp_settings = {
  from:           'moinmoin@grammar-blitz.fun',
  user_name:      'TM2DtlBvSF-mfoM3ucQacQ',
  password:       ENV['SENDGRID_API_KEY'],
  domain:         'grammar-blitz.fun',
  address:        "smtp.sendgrid.net",
  port:            465,
  authentication: :plain,
  enable_starttls_auto: true
}
