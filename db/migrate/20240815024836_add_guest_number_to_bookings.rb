class AddGuestNumberToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :guest_number, :integer
  end
end
