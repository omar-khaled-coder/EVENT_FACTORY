class Booking < ApplicationRecord
  belongs_to :space
  belongs_to :user # The user who made the booking
  belongs_to :owner, class_name: 'User' # The owner of the space
end
