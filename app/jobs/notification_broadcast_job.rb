class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(private_message)
    message = render_message(private_message)
    ActionCable.server.broadcast "notifications_#{private_message.user.id}_channel",
                                 message: message,
                                 conversation_id: private_message.conversation.id

    ActionCable.server.broadcast "notifications_#{private_message.receiver.id}_channel",
                           notification: render_notification(private_message),
                           message: message,
                           conversation_id: private_message.conversation.id
  end

  private

  def render_notification(message)
    NotificationsController.render partial: 'notifications/notification', locals: {message: message}
  end

  def render_message(message)
    PrivateMessagesController.render partial: 'private_messages/private_message',
                                      locals: {private_message: message}
  end
end