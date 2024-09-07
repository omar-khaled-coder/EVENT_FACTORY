class RemoveLastViewedAtFromChatrooms < ActiveRecord::Migration[7.1]
  def change
    remove_column :chatrooms, :last_viewed_at, :datetime
  end
end
