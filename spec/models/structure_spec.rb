require 'rails_helper'

RSpec.describe Structure, type: :model do
  describe 'associations' do
    it { should have_many(:elements) }
    it { should have_many(:exercices) }
    it { should have_many(:structure_elements) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:name) }
  end
end
