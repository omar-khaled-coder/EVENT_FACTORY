module ApplicationHelper
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
