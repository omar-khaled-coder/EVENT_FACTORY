class AddCovidResponsibilityToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :responsibility, :boolean
  end
end
