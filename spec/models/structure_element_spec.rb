require 'rails_helper'

RSpec.describe StructureElement, type: :model do
  describe 'assocations' do
    it { should belong_to(:structure) }
    it { should belong_to(:element) }
  end

  describe 'validations' do
    it { should validate_presence_of(:position)}
  end
end
