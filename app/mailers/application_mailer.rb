# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV["GMAIL_USERNAME"]
  layout 'mailer'
end
