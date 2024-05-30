# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatChannel, type: :channel do
  let(:user) { User.create(email: "test@example.com", password: "password") }

  before do
    stub_connection user_id: user.id
  end

  xit "subscribes to a stream when connected" do
    subscribe
    expect(subscription).to be_confirmed
    expect(streams).to include("chat_channel")
  end

  xit "broadcasts to the chat channel" do
    subscribe
    expect {
      perform :speak, message: "Hello"
    }.to have_broadcasted_to("chat_channel").with(message: "Hello", user: user.email)
  end
end
