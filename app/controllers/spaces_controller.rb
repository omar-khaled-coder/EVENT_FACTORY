class SpacesController < ApplicationController
  before_action :set_space, only: %i[ show edit update destroy ]

  # GET /spaces or /spaces.json
  def index
    @spaces = Space.accepted

    # The `geocoded` scope filters only spaces with coordinates
    #@spaces = Space.where.not(latitude: nil, longitude: nil)

    @markers = @spaces.geocoded.map do |space|
      {
        lat: space.latitude,
        lng: space.longitude #,
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
        # Uncomment the above line if you want each of your markers to display a info window when clicked
        # (you will also need to create the partial "/flats/map_box")
      }
    end
  end

  # GET /spaces/1 or /spaces/1.json
  def show
    @space = Space.find(params[:id])
    if @space.geocoded?
      @marker =
        {
          lat: @space.latitude,
          lng: @space.longitude
        }

    end
    @spaces = [@space]
    start_date = params.fetch(:start_date, Date.today).to_date


  @spaces = Space.where("start_date <= ? AND end_date >= ?", start_date.end_of_month, start_date.beginning_of_month)
  respond_to do |format|
    format.html
    format.js { render partial: 'simple_calendar/month_calendar', locals: { start_date: start_date, events: [] } }
  end
  end



  # GET /spaces/new
  def new
    @space = Space.new
  end

  # GET /spaces/1/edit
  def edit
  end

  # POST /spaces or /spaces.json
  def create
    @space = Space.new(space_params)
    @space.owner = current_user
    @space.status = 'pending'


    respond_to do |format|
      if @space.save
        format.html { redirect_to space_url(@space), notice: "Space was successfully created." }
        format.json { render :show, status: :created, location: @space }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spaces/1 or /spaces/1.json
  def update
    if space_params[:remove_images].present?
      space_params[:remove_images].each do |image_id|
        image = @space.images.find(image_id)
        image.purge
      end
    end

    if space_params[:images].present?
      @space.images.attach(space_params[:images])
    end

    respond_to do |format|
      if @space.update(space_params.except(:images, :remove_images))
        @space.update(status: 'pending') # Ensure status is set to pending
        format.html { redirect_to space_url(@space), notice: "Space was successfully updated, And waiting for the admin." }
        format.json { render :show, status: :ok, location: @space }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /spaces/1 or /spaces/1.json
  def destroy
    @space.destroy!

    respond_to do |format|
      format.html { redirect_to spaces_url, notice: "Space was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_space
      @space = Space.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def space_params
      params.require(:space).permit(:owner_id, :title, :description, :address, :city, :state, :country,
       :postal_code,  :capacity, :amenities, :price_per_hour, :status,
        :admin_comment, :price_per_day, :start_date, :end_date, :is_hourly_available, :is_daily_available,
         :latitude, :longitude, :available_from, :available_to, :minimum_rental_duration, space_type:[], remove_images: [], images:[])
    end
end
