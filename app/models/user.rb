class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_picture
  has_one_attached :govt_id_picture

  before_create :set_date_joined

  private

  def set_date_joined
    self.date_joined = Time.current
  end
end
console
