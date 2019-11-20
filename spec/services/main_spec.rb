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
    it 'shoud have the nominative case (because personal_pronoun is used as subject)' do
      create(:personal_pronoun, :first_singular_accusative)
      personal_pronouns = []
      10.times do
        @service.generate
        personal_pronouns << @service.subject
      end
      expect(personal_pronouns.uniq.length).to eq(1)
      expect(personal_pronouns.first.value).to eq('ich')
      expect(personal_pronouns.first.g_case).to eq('nominative')
    end

    it 'shoud be able to choose the third singular' do
      create(:personal_pronoun, :third_feminin_nominative)
      personal_pronouns = []
      10.times do
        @service.generate
        personal_pronouns << @service.subject
      end
      expect(personal_pronouns.uniq.length).to eq(1)
      expect(personal_pronouns.first.value).to eq('ich')
      expect(personal_pronouns.first.g_case).to eq('nominative')
    end
  end


  describe 'with s_v_do structure and accusative the article' do
    before(:each) { @article = @service.instance_eval { fetch_article('accusative', 'feminin') } }

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
    it 'article and noun should have the same gender' do
      # Line below: the gender in service is based on Article.all, therefor db need to
      # be populated with article from different gender
      article = create(:article, :definite_masculin_accusative)
      create(:noun, :masculin_object)
      noun = @service.instance_eval { fetch_noun('object') }
      expect(noun.gender).to eq(article.gender)
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
      create(:verb, :first_person_dative_that_go_with_people)
      expect(@verb.g_case).to eq(@service.g_case)
    end
  end

  describe 'with s_v_prep_do structure and accusative the preposition' do
    it 'shoud have the same gender as define in the initialize' do
      # Line below: the gender in service is based on Article.all, therefor db need to
      # be populated with article from different gender
      create(:article, :definite_masculin_accusative)
      create(:preposition, :accusative)
      create(:preposition, :dative)
      preposition = @service.instance_eval { fetch_preposition }
      expect(preposition.g_case).to eq(@service.g_case)
    end
  end
end

RSpec.describe SentenceBuilderService do
  it 'noun and article should have the same gender' do
    create(:personal_pronoun, :first_singular_nominative)
    create(:article, :definite_feminin_accusative)
    create(:article, :definite_masculin_accusative)
    # Noun and Verb instances are created by the join table. line bellow
    create(:verb_noun_link)
    create(:verb_noun_link, :accusative_masculin)
    @service = SentenceBuilderService.new(build(:exercice))
    20.times do
      @service.generate
      expect(@service.noun.gender).to eq(@service.article.gender)
    end
  end
end
