# spec/models/tag_spec.rb
require 'rails_helper'

# Test suite for the Tag model
RSpec.describe Tag, type: :model do
  # Association test
  # ensure an item record belongs to a single member record
  it { should belong_to(:member) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end