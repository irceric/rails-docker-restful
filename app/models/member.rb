class Member < ApplicationRecord
  # model association
  has_many :tags, dependent: :destroy
  
  # validations
  validates_presence_of :first_name, :last_name, :member_type
end
