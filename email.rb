Net::SMTP.start('christophe.clrd@gmail.com')

require 'net/smtp'

message = <<MESSAGE_END
From: Private Person <christophe.clrd@gmail.com>
To: A Test User <christophe.clrd@gmail.com>
Subject: SMTP e-mail test

This is a test e-mail message.
MESSAGE_END

Net::SMTP.start('localhost') do |smtp|
  smtp.send_message message, 'me@fromdomain.com', 'test@todomain.com'
end
