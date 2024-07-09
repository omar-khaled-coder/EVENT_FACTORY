json.extract! space, :id, :owner_id, :title, :description, :address, :city, :state, :country, :postal_code, :space_type, :capacity, :amenities, :price_per_hour, :price_per_day, :start_date, :end_date, :is_hourly_available, :is_daily_available, :created_at, :updated_at
json.url space_url(space, format: :json)
