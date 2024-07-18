class Space < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  #validates :status, inclusion: { in: %w[pending accepted declined] }

  enum status: { pending: 'pending', accepted: 'accepted', declined: 'declined' }

  has_many_attached :images

  validate :images_limit

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  private

  def images_limit
    errors.add(:images, "You can attach up to 15 images") if images.count > 15
  end
end
