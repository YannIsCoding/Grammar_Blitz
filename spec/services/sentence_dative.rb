require 'rails_helper'

RSpec.describe SentenceBuilderService do
  before(:each) do
    create(:personal_pronoun, :first_singular_nominative)
    create(:article, :definite_feminin_dative)
    # Noun and Verb instances are created by the join table. line bellow
    create(:verb_noun_link, :dative_form)
    @service = SentenceBuilderService.new(build(:exercice, :direct_object_dative))
    @result = @service.generate
  end

  describe 'Exercise with interrogative form should' do
    it 'give the element in the right order' do
      sentence = @result[:sentence].split(' ')
      expect(sentence[0]).to eq(@service.subject.value.capitalize)
      expect(sentence[1]).to eq(@service.verb.value)
      expect(sentence[2]).to eq(@service.article.value)
      expect(sentence[3]).to eq(@service.noun.value.capitalize)
    end

    it 'give the correct solution to the exercise' do
      solution = @result[:solution]
      expect(solution).to eq(@service.article.value)
    end
  end
end
