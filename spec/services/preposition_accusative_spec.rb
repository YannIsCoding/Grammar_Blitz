require 'rails_helper'

RSpec.describe 'Preposition accusative exercise' do
  before(:each) do
    create(:personal_pronoun, :first_singular_nominative)
    create(:article, :definite_masculin_accusative)
    create(:preposition, :accusative)
    # Noun and Verb instances are created by the join table. line bellow
    create(:verb, :first_person_sein)
    create(:noun, :masculin_idea)
    @service = SentenceBuilderService.new(build(:exercice, :accusative_preposition))
    @result = @service.generate
  end

  describe 'Exercise with prepositions should' do
    it 'give the element in the right order' do
      sentence = @result[:sentence].split(' ')
      expect(sentence[0]).to eq(@service.subject.value.capitalize)
      expect(sentence[1]).to eq(Verb.last.value)
      expect(sentence[2]).to eq(@service.preposition.value)
      expect(sentence[3]).to eq(@service.article.value)
      expect(sentence[4]).to eq(@service.noun.value.capitalize)
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

RSpec.describe SentenceBuilderService do
  it 'noun and article should have the same gender' do
    create(:personal_pronoun, :first_singular_nominative)
    create(:article, :definite_feminin_accusative)
    create(:article, :definite_masculin_accusative)
    create(:preposition, :accusative)
    create(:verb, :first_person_sein)
    create(:noun, :masculin_idea)
    create(:noun, :feminin_idea)
    @service = SentenceBuilderService.new(build(:exercice, :accusative_preposition))
    10.times do
      @service.generate
      expect(@service.noun.gender).to eq(@service.article.gender)
    end
  end
end
