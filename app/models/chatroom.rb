class Chatroom < ApplicationRecord
  belongs_to :user # The user initiating the chat
  belongs_to :owner, class_name: "User" # The owner of the space
  belongs_to :space

  has_many :messages, dependent: :destroy
end
