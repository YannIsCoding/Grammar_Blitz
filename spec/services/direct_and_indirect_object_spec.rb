require 'rails_helper'
RSpec.describe 'Exercise with direct and indirect object' do
  before(:each) do
    create(:personal_pronoun, :first_singular_nominative)
    create(:article, :definite_feminin_accusative)
    create(:article, :definite_feminin_dative)
    create(:article, :definite_masculin_accusative)
    create(:article, :definite_masculin_dative)
    # Noun and Verb instances are created by the join table. line bellow
    create(:noun, :feminin_person)
    create(:verb_noun_link, :for_io_do)
    @service = SentenceBuilderService.new(build(:exercice, :direct_indirect))
    @result = @service.generate
    @sentence = @result[:sentence].split(' ')
  end

  it 'the sentence should be composed of 6 elements' do
    expect(@sentence.length).to eq(6)
  end
  it 'the english should be composed of 7 elements' do
    expect(@result[:english].split(' ').length).to eq(7)
  end

  it 'the obfuscated elements should match the solution' do
    expect(@result[:sentence].split(' ')[@result[:hide_index][0]]).to eq(@result[:solution][0])
  end

  it 'the first article should be dative' do
    expect(@sentence[2]).to eq('der')
  end

  it 'the first noun should have the same gender as the first article' do
  end

  it 'the second article should be accusative' do
    expect(@sentence[4]).to eq('die')
  end

  it 'the solution should contains 2 elements' do
    expect(@result[:solution].class).to eq(Array)
    expect(@result[:solution].length).to eq(2)
  end
end
