class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from("notifications_#{current_user.id}_channel")
  end

  def unsubscribed
  end

  def send_message(data)
    conversation = Conversation.find_by(id: data['conversation_id'])
    if conversation && conversation.participates?(current_user)
      private_message = current_user.private_messages.build({body: data['message']})
      private_message.conversation = conversation
      private_message.save!
    end
  end
end
