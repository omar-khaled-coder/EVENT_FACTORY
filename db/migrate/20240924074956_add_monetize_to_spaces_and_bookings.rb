class AddMonetizeToSpacesAndBookings < ActiveRecord::Migration[7.1]
  def change
      # Add monetized fields for bookings (price)
      add_monetize :bookings, :price, currency: { present: false }

      # Add monetized fields for spaces (price per hour and price per day)
      add_monetize :spaces, :price_per_hour, currency: { present: false }
      add_monetize :spaces, :price_per_day, currency: { present: false }
  end
end
