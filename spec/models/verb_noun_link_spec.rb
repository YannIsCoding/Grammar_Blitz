require 'rails_helper'

RSpec.describe VerbNounLink, type: :model do
  describe 'assocations' do
    it { should belong_to(:verb) }
    it { should belong_to(:noun) }
  end
end
