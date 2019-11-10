require 'rails_helper'

RSpec.describe ProgressTracker, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'assocations' do
    it { should belong_to(:exercice) }
    it { should belong_to(:user) }
  end
end
