require 'rails_helper'
RSpec.describe 'Exercise with direct and indirect object' do
  before(:each) do
    create(:personal_pronoun, :first_singular_nominative)
    create(:article, :definite_feminin_accusative)
    create(:article, :definite_feminin_dative)
    create(:article, :definite_masculin_accusative)
    create(:article, :definite_masculin_dative)
    create(:preposition, :accusative)
    # create(:verb, :first_person_sein)
    # create(:noun, :masculin_object)
    # Noun and Verb instances are created by the join table. line bellow
    create(:verb_noun_link)
    @service = SentenceBuilderService.new(build(:exercice, :direct_indirect))
    @result = @service.generate
    @sentence = @result[:sentence].split(' ')
  end

  it 'the sentence should be composed of 6 elements' do
    expect(@sentence.length).to eq(6)
  end
  it 'the english should be composed of 6 elements' do
    expect(@result[:english].split(' ').length).to eq(6)
  end

  it 'the obfuscated should be composed of 6 elements' do
    expect(@result[:obfus].split(' ').length).to eq(10)
  end

  it 'the first article should be dative' do
    expect(@sentence[2]).to eq('der')
  end

  it 'the first noun should have the same gender as the first article' do
  end

  it 'the second article should be accusative' do
    expect(@sentence[4]).to eq('die')
  end
end

