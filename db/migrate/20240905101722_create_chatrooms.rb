class CreateChatrooms < ActiveRecord::Migration[7.1]
  def change
    create_table :chatrooms do |t|
      t.references :user, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: { to_table: :users }  # Reference the users table for owner
      t.references :space, null: false, foreign_key: true

      t.timestamps
    end
  end
end
