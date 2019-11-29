require 'rails_helper'

RSpec.describe Trial, type: :model do
  describe 'associations' do
    it { should belong_to(:exercice) }
    it { should belong_to(:user) }
  end
end
