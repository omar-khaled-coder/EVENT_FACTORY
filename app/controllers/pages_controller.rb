class PagesController < ApplicationController
  def home
  end

  def user_profile
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :profile_picture, :govt_id_picture)
  end
end
