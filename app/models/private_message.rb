class PrivateMessage < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: true

  after_create_commit do
    conversation.touch
    ::NotificationBroadcastJob.perform_later(self)
  end

  def receiver
    conversation.author == user ? conversation.receiver : conversation.author
  end
end
