# frozen_string_literal: true

class ChatRoomsController < ApplicationController
  def index
    @messages = Message.all
  end
end
