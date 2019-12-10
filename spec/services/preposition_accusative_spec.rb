require 'rails_helper'

RSpec.describe 'Preposition accusative exercise' do
  before(:each) do
    create(:personal_pronoun, :first_singular_nominative)
    @article = create(:article, :definite_masculin_accusative)
    @possessive_pronoun = create(:pronoun, :possessive_first_person_masculin_accusative)
    create(:preposition, :accusative)
    # Noun and Verb instances are created by the join table. line bellow
    create(:verb, :first_person_sein)
    create(:noun, :masculin_idea)
    @service = SentenceBuilderService.new(build(:exercice, :accusative_preposition))
    @result = @service.generate
  end

  describe 'Exercise with prepositions should' do
    it 'give the element in the right order' do
      sentence = @result[:value].split(' ')
      expect(sentence[0]).to eq(@service.subject.value.capitalize)
      expect(sentence[1]).to eq(Verb.last.value)
      expect(sentence[2]).to eq(Preposition.last.value)
      expect([@article.to_s, @possessive_pronoun.to_s]).to include(sentence[3])
      expect(sentence[4]).to eq(Noun.last.value.capitalize)
    end

    it 'select a noun matching the preposition' do
      create(:noun)
      5.times do
        @service.generate
        expect(@service.instance_eval { noun }).to eq(Noun.first)
      end
    end
  end
end
