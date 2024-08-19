class AddEventTypeToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :event_type, :string
  end
end
