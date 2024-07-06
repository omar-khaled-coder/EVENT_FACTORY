class PagesController < ApplicationController
  def home
  end

  def user_profile
    @user = current_user
  end
end
