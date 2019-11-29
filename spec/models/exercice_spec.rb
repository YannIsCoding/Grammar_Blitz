require 'rails_helper'

RSpec.describe Exercice, type: :model do
  describe 'associations' do
    it { should belong_to(:structure) }
    it { should have_many(:trials) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_uniqueness_of(:description) }
  end
end
