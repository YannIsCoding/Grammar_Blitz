require 'rails_helper'
RSpec.describe 'Exercise with direct and indirect object' do
  before(:each) do
    create(:personal_pronoun, :first_singular_nominative)
    create(:article, :definite_feminin_accusative)
    create(:article)
    create(:preposition, :accusative)
    # Noun and Verb instances are created by the join table. line bellow
    create(:verb, :first_person_sein)
    create(:noun, :masculin_object)
    create(:verb_noun_link)
    @service = SentenceBuilderService.new(build(:exercice, :direct_indirect))
    @result = @service.generate
  end

  it 'the sentence should be composed of 6 elements' do
    expect(@result[:sentence].split(' ').length).to eq(6)
  end
  it 'the english should be composed of 6 elements' do
    expect(@result[:english].split(' ').length).to eq(6)
  end
end

