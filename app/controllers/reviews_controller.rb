class ReviewsController < ApplicationController
  before_action :find_space, only: [:new, :create]
  before_action :check_booking_completed, only: [:new, :create]

  def new
    @review = Review.new
  end

  def create
    @review = @space.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @space, notice: 'Review submitted successfully.'
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def find_space
    @space = Space.find(params[:space_id])
  end

  def check_booking_completed
    @booking = Booking.find_by(space: @space, user: current_user, booking_status: 'confirmed')

    # Check if the event is completed
    if @booking.nil? || @booking.start_date > Date.today || (@booking.start_date == Date.today && @booking.end_hour > Time.current)
      redirect_to space_path(@space), alert: "You can only review this space after your event is completed."
    end
  end
end
