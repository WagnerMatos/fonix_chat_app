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
end
