require 'rails_helper'

RSpec.describe SentenceBuilderService do
  before(:each) do
    create(:personal_pronoun, :first_singular_nominative)
    create(:article, :definite_feminin_accusative)
    # Noun and Verb instances are created by the join table. line bellow
    create(:verb_noun_link)
    @service = SentenceBuilderService.new(build(:exercice))
    @result = @service.generate
  end

  describe 'with s_v_do structure and accusative, the personal pronoun' do
    before(:each) do
      @personal_pronoun = @service.instance_eval { fetch_subject }
    end

    it 'shoud have the nominative case (because it is subject)' do
      create(:personal_pronoun, :first_singular_accusative)
      expect(@personal_pronoun.value).to eq('ich')
      expect(@personal_pronoun.g_case).to eq('nominative')
    end

    it 'shoud have the same person has choosen in the initalize' do
      create(:personal_pronoun, :third_feminin_nominative)
      expect(@personal_pronoun.person).to eq(@service.person)
    end
  end

  describe 'with s_v_do structure and accusative the article' do
    before(:each) { @article = @service.instance_eval { fetch_article } }

    it 'shoud have the accusative case' do
      create(:article, :definite_feminin_dative)
      expect(@article.g_case).to eq('accusative')
    end

    it 'shoud have the same gender as define in initialize' do
      create(:article, :definite_masculin_accusative)
      expect(@article.gender).to eq(@service.gender)
    end

    it 'shoud be the same as the solution' do
      create(:article, :definite_feminin_dative)
      create(:article, :definite_masculin_accusative)
      article = @result[:sentence].split(' ')[2]
      expect(article).to eq(@result[:solution])
    end
  end

  describe 'with s_v_do structure and accusative the noun' do
    it 'shoud have the same gender as define in the initialize' do
      # Line below: the gender in service is based on Article.all, therefor db need to
      # be populated with article from different gender
      create(:article, :definite_masculin_accusative)
      create(:noun, :masculin_object)
      noun = @service.instance_eval { fetch_noun }
      expect(noun.gender).to eq(@service.gender)
    end
  end

  describe 'with s_v_do structure and accusative the verb' do
    before(:each) { @verb = @service.instance_eval { fetch_verb } }

    it 'shoud have the same person has the personal pronoun' do
      create(:verb, :third_plurial_accusative_that_go_with_object)
      personal_pronoun = @service.instance_eval { fetch_subject }
      expect(@verb.person).to eq(personal_pronoun.person)
    end

    it 'shoud have the same g_case as define in the initialize' do
      create(:verb, :first_person_dative_that_go_with_object)
      expect(@verb.g_case).to eq(@service.g_case)
    end
  end
end
