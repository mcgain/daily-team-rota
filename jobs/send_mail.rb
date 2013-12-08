#!/usr/bin/env ruby

require_relative '../mailer'
require_relative '../queue'

recipient = Queue.next
Mailer.send_rota_email_to recipient
