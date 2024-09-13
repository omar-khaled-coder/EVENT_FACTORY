module ApplicationHelper

  def country_name(country_code)
    country = ISO3166::Country[country_code]
    country&.iso_short_name || country_code
  end

  SPACE_TYPE_ICONS = {
    "Studio" => "fas fa-microphone",
    "Office" => "fas fa-briefcase",
    "Conference Room" => "fas fa-users",
    "Shooting Location" => "fa-solid fa-camera",
    "Event Venue" => "fa-solid fa-house",
    "Co-working Space" => "fa-regular fa-building",
    "Classroom" => "fa-solid fa-people-roof"
    # Add other space types and their corresponding icons here
  }

  def icon_for_space_type(space_type)
    SPACE_TYPE_ICONS[space_type] || "fas fa-question"
  end

  def icon_for_amenity(amenity)
    case amenity.downcase
    when 'wifi'
      'fas fa-wifi'
    when 'parking', 'free parking'
      'fas fa-parking'
    when 'pool', 'swimming pool'
      'fas fa-swimming-pool'
    when 'bathrooms'
      'fas fa-restroom'
    when 'kitchen'
      "fa-solid fa-kitchen-set"
    when 'snacks'
      "fa-solid fa-cookie-bite"
    when "private entrance"
      "fa-solid fa-dungeon"
    when 'sink'
      "fa-solid fa-sink"
    when "air conditioning"
      "fa-solid fa-wind"
    when 'heat'
      "fa-solid fa-temperature-arrow-up"
    # Add more cases for other amenities
    else
      'fas fa-check' # Default icon
    end
  end

  def time_options
    options = []
    start_time = Time.parse("00:00")
    end_time = Time.parse("23:30")

    while start_time <= end_time
      options << [start_time.strftime("%I:%M %p"), start_time.strftime("%H:%M")]
      start_time += 30.minutes
    end

    options
  end

  def generate_time_options(start_time, end_time, step_minutes = 30)
    times = []
    current_time = start_time

    while current_time <= end_time
      times << current_time
      current_time += step_minutes.minutes
    end

    times
  end
end
