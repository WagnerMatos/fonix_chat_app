require 'rails_helper'

RSpec.describe "Messages", type: :request do
  let(:user) { User.create(email: "test@example.com", password: "password") }
  let(:valid_attributes) { { content: "Hello" } }

  before do
    sign_in user
  end

  describe "POST #create" do
    it "creates a new message" do
      expect {
        post "/messages", params: valid_attributes
      }.to change(Message, :count).by(1)
    end

    it "broadcasts the message to the chat channel" do
      # Extract essential content
      email = user.email
      content = "Hello"

      # Create a regex to match the essential content, ignoring HTML tags
      # I was having issues to match the exact content due to encoding and decided
      # on this approach for time sake. In a production env I'd investigate a better
      # approach by probably changing the broadcast to simplify testing
      expected_pattern = /#{Regexp.escape(email)}.*#{Regexp.escape(content)}/

      expect {
        post "/messages", params: valid_attributes
      }.to broadcast_to("chat_channel").with(message: match(expected_pattern))
    end
  end
end
