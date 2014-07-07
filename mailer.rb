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
              from: recipient,
              subject: "#{recipient} is on kitchen duty today",
              body: EMAIL_BODY)
  end

  def self.send_rota_email_to_flowdock(recipients)
    recipients_str = recipients.join(' and ') + ' are on kitchen duty today'
    Pony.mail(to: 'montreal@shopify.flowdock.com',
              from: recipients.first,
              subject: recipients_str,
              body: recipients_str)
  end
end

EMAIL_BODY = <<-EOS
Good morning!

You are on kitchen duty today. This involves:
* Emptying the dishwasher if it has finished and putting the stuff in the sink in it.
* Washing up the bain-marie, and anything else too big to fit in the dishwasher.
* Putting the leftovers in the fridge.
* Wipe the table if it is messy.

It does not involve:
* Cleaning up other people's mess.

Thanks,

The rest of the office.
EOS
