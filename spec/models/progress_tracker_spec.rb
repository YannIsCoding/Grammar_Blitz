require 'rails_helper'

RSpec.describe ProgressTracker, type: :model do
  describe 'assocations' do
    it { should belong_to(:exercice) }
    it { should belong_to(:user) }
    it { should have_many(:trials) }
  end
end
