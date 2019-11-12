require 'rails_helper'

RSpec.describe Noun, type: :model do
  describe 'associations' do
    it { should have_many(:verb_noun_links) }
    it { should have_many(:verbs) }
  end
end
