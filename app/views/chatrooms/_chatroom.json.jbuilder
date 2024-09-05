json.extract! chatroom, :id, :user_id, :owner_id, :space_id, :created_at, :updated_at
json.url chatroom_url(chatroom, format: :json)
