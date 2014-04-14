require 'pony'

class Mailer
  Pony.options = {
    via: :smtp,
    via_options: {
      address: 'smtp.sendgrid.net',
      port: '587',
      domain: 'heroku.com',
      user_name: ENV['SENDGRID_USERNAME'],
      password: ENV['SENDGRID_PASSWORD'],
      authentication: :plain,
      enable_starttls_auto: true
    }
  }

  def self.send_rota_email_to(recipient)
    Pony.mail(to: recipient,
              cc: 'checkout@shopify.flowdock.com',
              from: recipient,
              subject: "#{recipient} is on errors duty today",
              body: EMAIL_BODY)
  end
end

EMAIL_BODY = <<-EOS
Good morning!

It is your job to keep an eye on the dashboards today. If something goes wrong with
gift cards or checkout, we need to be the first to know.

Some useful dashboards are:
https://logs.shopify.com:8000/en-US/app/search/CheckoutDashboard
https://app.datadoghq.com/dash/dash/18553?live=true&from_ts=1397481759777&to_ts=1397485359777&tile_size=m

Thanks,

The Errbit mailer roster system thingy
EOS
