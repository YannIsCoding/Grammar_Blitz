require 'rails_helper'

RSpec.describe SentenceBuilderService do

  describe 'The service should throw an error if' do
    it 'no gender is found' do
      lambda { SentenceBuilderService.new(build(:exercice)) }.should raise_error(RuntimeError)
    end

    it 'no personal pronoun is found' do
      create(:article)
      lambda { SentenceBuilderService.new(build(:exercice)).generate }.should raise_error(RuntimeError)
    end

    it 'no article is found' do
      create(:article, :definite_feminin_dative)
      create(:personal_pronoun)
      lambda { SentenceBuilderService.new(build(:exercice)).generate }.should raise_error(RuntimeError)
    end

    it 'no noun is found' do
      create(:article)
      create(:personal_pronoun)
      lambda { SentenceBuilderService.new(build(:exercice)).generate }.should raise_error(RuntimeError)
    end

    it 'no verb is found' do
      create(:article)
      create(:personal_pronoun)
      create(:noun)
      lambda { SentenceBuilderService.new(build(:exercice)).generate }.should raise_error(RuntimeError)
    end

    it 'no preposition is found' do
      create(:article)
      create(:personal_pronoun, :first_singular_nominative)
      create(:verb_noun_link)
      lambda { SentenceBuilderService.new(build(:exercice)).generate }.should raise_error(RuntimeError)
    end
  end
end
