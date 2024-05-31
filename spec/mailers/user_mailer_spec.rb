require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "weekly_report" do
    let(:user) { User.create(email: "test@example.com", password: "password") }
    let(:mail) { UserMailer.weekly_report(user, 200, 350) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Weekly Chat Report')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('200 messages have been exchanged in the last week. 350 since your last message.')
    end
  end
end
