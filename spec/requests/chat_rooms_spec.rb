# frozen_string_literal: trues

require 'rails_helper'

RSpec.describe ChatRoomsController, type: :request do
  let(:user) { User.create(email: "test@example.com", password: "password") }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns a success response" do
      get "/"
      expect(response).to be_successful
    end

    it "assigns all messages to @messages" do
      message1 = user.messages.create(content: "Hello")
      message2 = user.messages.create(content: "World")
      get "/"
      expect(response.body).to include(message1.content)
      expect(response.body).to include(message2.content)
    end
  end
end
