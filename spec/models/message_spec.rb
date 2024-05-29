require 'rails_helper'

RSpec.describe Message, type: :model do
  it "is valid with valid attributes" do
    user = User.create(email: "test@example.com", password: "password")
    message = Message.new(content: "Hello", user: user)
    expect(message).to be_valid
  end

  it "is not valid without content" do
    user = User.create(email: "test@example.com", password: "password")
    message = Message.new(content: nil, user: user)
    expect(message).not_to be_valid
  end

  it "is not valid without a user" do
    message = Message.new(content: "Hello", user: nil)
    expect(message).not_to be_valid
  end
end
