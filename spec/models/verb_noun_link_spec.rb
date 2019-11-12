require 'rails_helper'

RSpec.describe VerbNounLink, type: :model do
  describe 'assocations' do
    it { should belong_to(:verb) }
    it { should belong_to(:noun) }
  end

  describe 'validations' do
    it { should validate_presence_of(:verb_id)}
    it { should validate_presence_of(:noun_id)}
  end
end
