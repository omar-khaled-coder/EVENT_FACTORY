module ApplicationHelper

  def country_name(country_code)
    country = ISO3166::Country[country_code]
    country&.iso_short_name || country_code
  end

  SPACE_TYPE_ICONS = {
    "Studio" => "fas fa-microphone",
    "Office" => "fas fa-briefcase",
    "Conference Room" => "fas fa-users",
    "Shooting Location" => "fa-solid fa-camera"
    # Add other space types and their corresponding icons here
  }

  def icon_for_space_type(space_type)
    SPACE_TYPE_ICONS[space_type] || "fas fa-question"
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
