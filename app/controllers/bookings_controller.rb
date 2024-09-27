class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy, :accept, :decline, :cancel]
  # GET /bookings or /bookings.json

  def index
    @future_bookings = current_user.bookings.where('start_date >= ?', Date.today).order(start_date: :asc)
    @past_bookings = current_user.bookings.where('start_date < ?', Date.today).order(start_date: :desc)
  end

  # GET /bookings/1 or /bookings/1.json
  def show
    @booking = Booking.find(params[:id])
    @space = @booking.space
    @marker = {
     lat: @booking.space.latitude,
     lng: @booking.space.longitude
    }

  end

  def owner_dashboard
    @spaces = current_user.spaces
    @bookings = Booking.where(owner: current_user) || [] # Ensures @bookings is never nil
    @upcoming_bookings = Booking.where(space: @spaces)
    .where('start_date >= ?', Date.today)
    .where.not(booking_status: 'canceled')
    .order(start_date: :asc)

    # Filter previous bookings, excluding canceled ones
    @previous_bookings = Booking.where(space: @spaces)
        .where('start_date < ?', Date.today)
        .where.not(booking_status: 'canceled')
        .order(start_date: :desc)
        @canceled_bookings = Booking.where(space: @spaces, booking_status: 'canceled').order(start_date: :desc)
  end

  def accept
    update_status('confirmed')
  end

  def decline
    update_status('declined')
  end

  def cancel
    if current_user == @booking.user || current_user == @booking.owner
      update_status('canceled')
    else
      redirect_to bookings_path, alert: 'You are not authorized to cancel this booking.'
    end
  end

  # GET /bookings/new
  def new
    @space = Space.find(params[:space_id])

    @booking = Booking.new(
      space_id: @space.id,
      user_id: current_user.id,
      owner_id: @space.owner_id,
      start_date: params[:booking_date],
      start_hour: params[:start_time],
      end_hour: params[:end_time],
      guest_number: params[:guest_number],
      price: params[:price] # assuming you pass the price as a parameter


    )
  end


  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings or /bookings.json
  def create
    @space = Space.find(params[:booking][:space_id])
    @booking = Booking.new(booking_params.merge(user_id: current_user.id, owner_id: @space.owner_id))

    if @booking.save
      redirect_to @booking, notice: 'Booking was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end



  # PATCH/PUT /bookings/1 or /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to booking_url(@booking), notice: "Booking was successfully updated." }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /bookings/1 or /bookings/1.json
  def destroy
    @booking.destroy!

    respond_to do |format|
      format.html { redirect_to bookings_url, notice: "Booking was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def update_status(new_status)

      if @booking.update(booking_status: new_status)
        redirect_to owner_dashboard_path, notice: "Booking status updated to #{new_status}."
      else
        redirect_to owner_dashboard_path, alert: 'Failed to update booking status.'
      end

    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(:space_id, :user_id, :owner_id, :start_date, :end_date, :start_hour, :end_hour, :price, :payment_status, :booking_status, :guest_number, :event_type, :responsibility)
    end

end
