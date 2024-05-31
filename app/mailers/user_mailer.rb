# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def weekly_report(user, weekly_count, total_count)
    @user = user
    @weekly_count = weekly_count
    @total_count = total_count
    mail(to: @user.email, subject: 'Weekly Chat Report')
  end
end
