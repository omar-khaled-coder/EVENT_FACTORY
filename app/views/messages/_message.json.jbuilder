json.extract! message, :id, :chatroom_id, :user_id, :content, :created_at, :updated_at
json.url message_url(message, format: :json)
