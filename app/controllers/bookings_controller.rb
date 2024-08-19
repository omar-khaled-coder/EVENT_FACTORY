class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]

  # GET /bookings or /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1 or /bookings/1.json
  def show
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

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(:space_id, :user_id, :owner_id, :start_date, :end_date, :start_hour, :end_hour, :price, :payment_status, :booking_status, :guest_number, :event_type)
    end
end
