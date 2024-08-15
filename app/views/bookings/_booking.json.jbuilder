json.extract! booking, :id, :space_id, :user_id, :owner_id, :start_date, :end_date, :start_hour, :end_hour, :price, :payment_status, :booking_status, :created_at, :updated_at
json.url booking_url(booking, format: :json)
