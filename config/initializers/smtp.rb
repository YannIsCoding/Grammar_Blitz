ActionMailer::Base.smtp_settings = {
  domain:        'grammar-blitz.fun',
  address:        "smtp.sendgrid.net",
  port:            '465',
  authentication: :plain,
  user_name:      'TM2DtlBvSF-mfoM3ucQacQ',
  password:       ENV['SENDGRID_API_KEY'],
  tls: true
}
