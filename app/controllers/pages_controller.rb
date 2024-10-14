class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:user_profile]
  before_action :authorize_space_requests_access, only: [:space_requests]

  def home
    start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
    start_date_range = start_date.beginning_of_month..start_date.end_of_month

    # Example for displaying bookings for the current owner
    @bookings = Booking.where(owner: current_user, start_date: start_date_range).order(:start_date, :start_hour)
  end


  def user_profile
    @user = User.find(params[:id])  # Find user by ID from the URL
        @spaces = @user.spaces
  end

  def space_requests
    @spaces = Space.where(status: 'pending')
  end

  def approve
    @space = Space.find(params[:id])
    @space.update(status: 'accepted', admin_comment: params[:admin_comment])

    redirect_to space_requests_path, notice: "Space approved."
  end

  def reject
    @space = Space.find(params[:id])
    @space.update(status: 'declined', admin_comment: params[:admin_comment])

    redirect_to space_requests_path, notice: "Space rejected with comments."
  end

  def policies
  end

  private

  def authorize_space_requests_access
    unless user_signed_in? && current_user.email == "omar@gmail.com"
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :profile_picture, :govt_id_picture)
  end
end
