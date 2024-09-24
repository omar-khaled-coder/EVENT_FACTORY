class Booking < ApplicationRecord
  belongs_to :space
  belongs_to :user # The user who made the booking
  belongs_to :owner, class_name: 'User' # The owner of the space
  validates :responsibility, acceptance: { message: 'You must accept the COVID-19 responsibility agreement.' }

  # Update default_scope to order by start_date and start_hour
  default_scope -> { order(:start_date, :start_hour) }  # Corrected ordering

  def time
    "#{start_hour.strftime('%I:%M %p')} - #{end_hour.strftime('%I:%M %p')}"  # Use start_hour and end_hour
  end
  # Monetize the 'price_cents' column (automatically handles the currency)
  monetize :price_cents, with_model_currency: :currency
end
