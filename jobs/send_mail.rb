#!/usr/bin/env ruby

require_relative '../mailer'
require_relative '../queue'

return if Date.today.saturday? || Date.today.sunday?
recipient = Queue.next
Mailer.send_rota_email_to recipient
