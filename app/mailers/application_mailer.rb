# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'MAAKS公式'
  layout 'mailer'
end
