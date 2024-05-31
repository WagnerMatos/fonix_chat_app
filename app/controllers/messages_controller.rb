# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    message = current_user.messages.create!(content: message_params[:content])
    ActionCable.server.broadcast "chat_channel", { message: render_message(message) }
    head :ok
  end

  private

  def render_message(message)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message }
    )
  end

  def message_params
    params.permit(:content)
  end
end
