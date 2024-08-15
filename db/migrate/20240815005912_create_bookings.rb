class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.bigint :space_id
      t.bigint :user_id
      t.bigint :owner_id
      t.date :start_date
      t.date :end_date
      t.time :start_hour
      t.time :end_hour
      t.decimal :price
      t.string :payment_status, default: "pending"
      t.string :booking_status, default: "pending"
      t.timestamps
    end
  end
end
