class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: %i[ show edit update destroy ]

  # GET /chatrooms or /chatrooms.json
  def index
    @chatrooms = Chatroom.where("chatrooms.user_id = :user_id OR chatrooms.owner_id = :user_id", user_id: current_user.id)
                         .left_joins(:messages)
                         .group("chatrooms.id")
                         .order(Arel.sql("COALESCE(MAX(messages.created_at), chatrooms.updated_at) DESC"))
    @message = Message.new
  end


  # GET /chatrooms/1 or /chatrooms/1.json
  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    @messages = @chatroom.messages.order(created_at: :asc)

    # Update last viewed time for the current user
    if current_user == @chatroom.owner
      @chatroom.update(owner_last_viewed_at: Time.current)
    else
      @chatroom.update(user_last_viewed_at: Time.current)
    end
  end


  # GET /chatrooms/new
  def new
    @chatroom = Chatroom.new
  end

  # GET /chatrooms/1/edit
  def edit
  end

  # POST /chatrooms or /chatrooms.json
  def create
    # Check if a chatroom already exists between the user, owner, and space
    @chatroom = Chatroom.find_by(user_id: chatroom_params[:user_id], owner_id: Space.find(chatroom_params[:space_id]).owner_id, space_id: chatroom_params[:space_id])

    if @chatroom
      # Redirect to the existing chatroom
      redirect_to chatroom_url(@chatroom), notice: "Chatroom already exists."
    else
      # If no chatroom exists, create a new one
      @chatroom = Chatroom.new(chatroom_params)
      @chatroom.owner_id = Space.find(chatroom_params[:space_id]).owner_id

      respond_to do |format|
        if @chatroom.save
          format.html { redirect_to chatroom_url(@chatroom), notice: "Chatroom was successfully created." }
          format.json { render :show, status: :created, location: @chatroom }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @chatroom.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /chatrooms/1 or /chatrooms/1.json
  def update
    respond_to do |format|
      if @chatroom.update(chatroom_params)
        format.html { redirect_to chatroom_url(@chatroom), notice: "Chatroom was successfully updated." }
        format.json { render :show, status: :ok, location: @chatroom }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatrooms/1 or /chatrooms/1.json
  def destroy
    @chatroom.destroy!

    respond_to do |format|
      format.html { redirect_to chatrooms_url, notice: "Chatroom was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chatroom
      @chatroom = Chatroom.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chatroom_params
      params.require(:chatroom).permit(:user_id, :owner_id, :space_id)
    end
end
