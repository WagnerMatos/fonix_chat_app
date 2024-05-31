# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # This is a basic implementation of report generation. For production consider different approaches, i.e. jobs:
  # A main job that'd trigger a secondary job for each user, etc
  def self.send_weekly_report
    User.find_each do |user|
      last_message_time = user.messages.order(:created_at).last&.created_at || Time.at(0)
      weekly_count = Message.where('created_at >= ?', 1.week.ago).count
      total_count = Message.where('created_at >= ?', last_message_time).count
      UserMailer.weekly_report(user, weekly_count, total_count).deliver_now
    end
  end
end
