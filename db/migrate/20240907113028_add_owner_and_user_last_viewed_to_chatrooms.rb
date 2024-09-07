class AddOwnerAndUserLastViewedToChatrooms < ActiveRecord::Migration[7.1]
  def change
    add_column :chatrooms, :owner_last_viewed_at, :datetime
    add_column :chatrooms, :user_last_viewed_at, :datetime
  end
end
