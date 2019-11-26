require 'rails_helper'

RSpec.describe SentenceBuilderService do
  before(:each) do
    create(:personal_pronoun, :first_singular_nominative)
    create(:article, :definite_feminin_accusative)
    # Noun and Verb instances are created by the join table. line bellow
    create(:verb_noun_link)
    @service = SentenceBuilderService.new(build(:exercice, :question_accusative))
    @result = @service.generate
  end

  describe 'Exercise with interrogative form should' do
    it 'start with the verb followed by the subject' do
      sentence = @result[:sentence].split(' ')
      expect(sentence[0]).to eq(@service.verb.value.capitalize)
      expect(sentence[1]).to eq(@service.subject.value)
      expect(sentence[2]).to eq(@service.article.value)
      expect(sentence[3]).to eq("#{@service.noun.value.capitalize}?")
    end

    it 'give the correct solution to the exercise' do
      solution = @result[:solution]
      expect(solution.first).to eq(@service.article.value)
    end
  end
end
