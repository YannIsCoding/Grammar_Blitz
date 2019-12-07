require 'rails_helper'

RSpec.describe SentenceBuilderService do
  before(:each) do
    create(:personal_pronoun, :first_singular_nominative)
    create(:article)
    # Noun and Verb instances are created by the join table. line bellow
    create(:verb_noun_link)
    @service = SentenceBuilderService.new(build(:exercice))
    @result = @service.generate
  end

  describe 'Exercise with interrogative form should' do
    it 'give the element in the right order' do
      sentence = @result[:sentence].split(' ')
      expect(sentence[0]).to eq(@service.subject.value.capitalize)
      expect(sentence[1]).to eq(Verb.last.value)
      expect(sentence[2]).to eq(@service.article.value)
      expect(sentence[3]).to eq(@service.noun.value.capitalize)
    end
  end
end
