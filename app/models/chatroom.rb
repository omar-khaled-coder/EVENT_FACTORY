class Chatroom < ApplicationRecord
  belongs_to :user # The user initiating the chat
  belongs_to :owner, class_name: "User" # The owner of the space
  belongs_to :space

  has_many :messages, dependent: :destroy

  # Check if there are new messages for the current user
  def has_new_messages?(current_user)
    last_message = messages.order(created_at: :desc).first
    return false unless last_message

    # Check if the user is the owner or the user and compare the last viewed time
    if current_user == owner
      owner_last_viewed_at.nil? || last_message.created_at > owner_last_viewed_at
    else
      user_last_viewed_at.nil? || last_message.created_at > user_last_viewed_at
    end
  end

  # Count the number of new messages since the last time the user or owner viewed the chatroom
  def new_message_count(current_user)
    if current_user == owner
      messages.where("created_at > ?", owner_last_viewed_at || Time.zone.now).count
    else
      messages.where("created_at > ?", user_last_viewed_at || Time.zone.now).count
    end
  end
end
