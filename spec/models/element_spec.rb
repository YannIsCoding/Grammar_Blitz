require 'rails_helper'

RSpec.describe Element, type: :model do

  describe 'associations' do
    it { should have_many(:structures) }
    it { should have_many(:structure_elements) }
  end

  describe 'validates' do
    it { should validate_presence_of(:value) }
    it { should validate_uniqueness_of(:value) }
  end
end

