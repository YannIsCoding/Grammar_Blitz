require 'rails_helper'

RSpec.describe SentenceBuilderService do
  before(:each) do
    create(:personal_pronoun, :first_singular_nominative)
    create(:pronoun, :possessive_first_person_feminin_dative)
    create(:article, :definite_feminin_dative)
    # Noun and Verb instances are created by the join table. line bellow
    create(:verb_noun_link, :dative_form)
    @service = SentenceBuilderService.new(build(:exercice, :direct_object_dative))
  end

  describe 'Exercise with s_v_do structure and dative should' do
    it 'give the element in the right order' do
      10.times do
        @result = @service.generate
        sentence = @result[:value].split(' ')
        expect(sentence[0]).to eq(@service.subject.value.capitalize)
        expect(sentence[1]).to eq(Verb.last.value)
        expect([Article.last.value, Pronoun.last.value]).to include(sentence[2])
        expect(sentence[3]).to eq(Noun.last.value.capitalize)
      end
    end
  end
end
