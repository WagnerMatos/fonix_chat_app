# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatChannel, type: :channel do
  let(:user) { User.create(email: "test@example.com", password: "password") }

  before do
    stub_connection current_user: user
  end

  describe "#subscribe" do
    it "subscribes to a stream when connected" do
      subscribe
      expect(subscription).to be_confirmed
      expect(subscription.streams).to include("chat_channel")
    end
  end

  describe "#speak" do

    it 'creates a message' do
      subscribe
      expect {
        perform :speak, message: 'Hello, world!'
      }.to change(Message, :count).by(1)

      message = Message.last
      expect(message.content).to eq('Hello, world!')
      expect(message.user).to eq(user)
    end

    it "broadcasts to the chat channel" do
      subscribe
      expect {
        perform :speak, message: "Hello"
      }.to have_broadcasted_to("chat_channel")
    end
  end
end
