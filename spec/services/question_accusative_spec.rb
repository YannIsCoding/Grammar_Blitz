require 'rails_helper'

RSpec.describe SentenceBuilderService do
  before(:each) do
    create(:personal_pronoun, :first_singular_nominative)
    create(:pronoun, :possessive_first_person_feminin_accusative)
    create(:article, :definite_feminin_accusative)
    # Noun and Verb instances are created by the join table. line bellow
    create(:verb_noun_link)
    @service = SentenceBuilderService.new(build(:exercice, :question_accusative))
    @result = @service.generate
  end

  describe 'Exercise with interrogative form should' do
    it 'start with the verb followed by the subject' do
      10.times do
        sentence = @result[:sentence].split(' ')
        expect(sentence[0]).to eq(Verb.last.value.capitalize)
        expect(sentence[1]).to eq(@service.subject.value)
        expect([Article.last.value, Pronoun.last.value]).to include(sentence[2])
        expect(sentence[3]).to eq("#{Noun.last.value.capitalize}?")
      end
    end
  end
end
