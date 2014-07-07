#!/usr/bin/env ruby

require_relative '../mailer'
require_relative '../queue'

return if Date.today.friday? || Date.today.saturday? || Date.today.sunday?
recipient1 = Queue.next
recipient2 = Queue.next
Mailer.send_rota_email_to recipient1
Mailer.send_rota_email_to recipient2
Mailer.send_rota_email_to_flowdock recipient1, recipient2
