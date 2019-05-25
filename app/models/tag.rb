class Tag < ApplicationRecord
  # model association
  belongs_to :member

  # validation
  validates_presence_of :name
end
