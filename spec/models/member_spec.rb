# spec/models/member_spec.rb
require 'rails_helper'

# Test suite for the Member model
RSpec.describe Member, type: :model do
  # Association test
  # ensure Member model has a 1:m relationship with the Tag model
  it { should have_many(:tags).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:member_type) }
end