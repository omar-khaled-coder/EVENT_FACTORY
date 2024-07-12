class Space < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  #validates :status, inclusion: { in: %w[pending accepted declined] }

  enum status: { pending: 'pending', accepted: 'accepted', declined: 'declined' }
end
