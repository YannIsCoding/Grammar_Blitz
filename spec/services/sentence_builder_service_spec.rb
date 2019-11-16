require 'rails_helper'

RSpec.describe SentenceBuilderService do
  before(:each) do
    create(:personal_pronoun, :first_person_nominative)
    create(:article, :definite_feminin_accusative)
    create(:verb_noun_link)
    @result = SentenceBuilderService.new(build(:exercice)).generate
  end
  describe 'with s_v_do structure and accusative' do
    it 'shoud select the personal pronoun with the right g_case' do
      create(:personal_pronoun, :first_person_accusative)
      personal_pronoun = @result[:sentence].split(' ')[0]
      expect(personal_pronoun).to eq('Ich')
      expect(personal_pronoun).not_to eq('mich')
    end

    it 'shoud select the article with the right g_case' do
      create(:article, :definite_feminin_dative)
      article = @result[:sentence].split(' ')[2]
      expect(article).to eq('die')
      expect(article).not_to eq('der')
      expect(article).to eq(@result[:solution])
    end

    it 'shoud select the noun with the right attributes' do
      create(:noun, :masculin_object)
      @result = SentenceBuilderService.new(build(:exercice)).generate
      noun = @result[:sentence].split(' ')[3]
      expect(noun).to eq('Kiste')
      expect(noun).not_to eq('teppich')
    end
  end
end
