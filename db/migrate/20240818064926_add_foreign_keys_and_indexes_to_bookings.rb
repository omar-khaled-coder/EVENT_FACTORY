class AddForeignKeysAndIndexesToBookings < ActiveRecord::Migration[7.1]
  def change
    unless foreign_key_exists?(:bookings, :spaces, column: :space_id)
      add_foreign_key :bookings, :spaces, column: :space_id
    end

    unless foreign_key_exists?(:bookings, :users, column: :user_id)
      add_foreign_key :bookings, :users, column: :user_id
    end

    unless foreign_key_exists?(:bookings, :users, column: :owner_id)
      add_foreign_key :bookings, :users, column: :owner_id
    end

    # Add indexes
    add_index :bookings, :space_id unless index_exists?(:bookings, :space_id)
    add_index :bookings, :user_id unless index_exists?(:bookings, :user_id)
    add_index :bookings, :owner_id unless index_exists?(:bookings, :owner_id)
  end
end
