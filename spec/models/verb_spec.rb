require 'rails_helper'

RSpec.describe Verb, type: :model do
  describe 'associations' do
    it { should have_many(:verb_noun_links) }
    it { should have_many(:nouns) }
  end
end
