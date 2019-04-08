# frozen_string_literal: true

# Base Application mailer for project
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
