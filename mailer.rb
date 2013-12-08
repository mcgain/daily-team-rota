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
              from: 'richard.mcgain@jadedpixel.com',
              subject: 'You are responsible for errbit today',
              body: EMAIL_BODY)
  end
end

EMAIL_BODY = <<-EOS
Good morning!

Please keep an eye on errbit error reported today.
If an error should be fixed by the checkout team,
raise an issue and tag it with 'AR Checkout Area'.

If it looks important, you should probably tell people!

If you cannot do this today, please ask someone else to cover for you.

Thanks,

The Errbit mailer roster system thingy
EOS
