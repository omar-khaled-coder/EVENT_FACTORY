class PagesController < ApplicationController
  def home
  end

  def user_profile
    @user = current_user
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

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :profile_picture, :govt_id_picture)
  end
end
