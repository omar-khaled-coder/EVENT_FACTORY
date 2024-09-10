class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #mount_uploader :profile_picture, ProfilePictureUploader
  #mount_uploader :govt_id_picture, GovtIdPictureUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

          has_one_attached :profile_picture
          has_one_attached :govt_id_picture

  #before_create :set_date_joined

  #private

  #def set_date_joined
   # self.date_joined = Time.current
  #end
  has_many :reviews
  has_many :spaces, foreign_key: 'owner_id'
  has_many :bookings, dependent: :destroy # A User can have many bookings
  has_many :owned_bookings, through: :spaces, source: :bookings # A User can have many bookings through owned spaces
  def owner?
    spaces.exists? # Checks if the user owns any spaces
  end
end
