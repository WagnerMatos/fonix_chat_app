require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_email) { "test@example.com" }
  let(:invalid_email) { "invalid_email" }

  it "is valid with valid attributes" do
    user = User.new(email: valid_email, password: "password")
    expect(user).to be_valid
  end

  it "is not valid without an email" do
    user = User.new(email: nil, password: "password")
    expect(user).not_to be_valid
  end

  it "is not valid with an invalid email" do
    user = User.new(email: invalid_email, password: "password")
    expect(user).not_to be_valid
  end

  it "is not valid without a password" do
    user = User.new(email: valid_email, password: nil)
    expect(user).not_to be_valid
  end

  it "is not valid with a duplicate email" do
    User.create(email: valid_email, password: "password")
    user = User.new(email: valid_email, password: "password")
    expect(user).not_to be_valid
  end

  describe '.send_weekly_report' do
    let(:user1) { User.create!(email: 'user1@example.com', password: "password") }
    let(:user2) { User.create!(email: 'user2@example.com', password: "password") }

    before do
      user1.messages.create!(created_at: 2.weeks.ago, content: "Hello")
      user1.messages.create!(created_at: 3.days.ago, content: "World")
      user1.messages.create!(created_at: 1.day.ago, content: "World")

      user2.messages.create!(created_at: 3.days.ago, content: "User 2")
      user2.messages.create!(created_at: 1.day.ago, content: "User 2")

      allow(UserMailer).to receive_message_chain(:weekly_report, :deliver_now)
      User.send_weekly_report
    end

    it 'sends a weekly report email to each user' do
      expect(UserMailer).to have_received(:weekly_report).with(user1, 4, 2).once
      expect(UserMailer).to have_received(:weekly_report).with(user2, 4, 1).once
    end
  end
end
