require 'rails_helper'

RSpec.describe VerbPractice do
  before(:each) do
    @user = create(:user)
    @exercice = create(:exercice)
    @sentence = create(:sentence, exercice: @exercice, user: @user)

    @first_verb = create(:verb)
    @second_verb = create(:verb, value: 'kauft', person: 'third_singular')
    @third_verb = create(:verb, value: 'kaufen', person: 'first_plurial')

    create(:bucket, user: @user, level: :zero, verb: @first_verb)
    create(:bucket, user: @user, level: :short, verb: @second_verb)
    create(:bucket, user: @user, level: :long, verb: @third_verb)
  end

  describe 'with 3 buckets representing each 3 levels' do
    it 'returns the correct proportion' do
      verb_practice = VerbPractice.new(preterit: 'kaufen',
                                       user: @user,
                                       trials: [])
      expect(verb_practice.verbs_prob.count(@first_verb.id)).to eq 4
      expect(verb_practice.verbs_prob.count(@second_verb.id)).to eq 2
      expect(verb_practice.verbs_prob.count(@third_verb.id)).to eq 1
    end

    it 'removes 1 verb element when 1 trials exist' do
      create(:trial, verb: @first_verb, sentence: @sentence,
                     exercice: @exercice, user: @user)

      verb_practice = VerbPractice.new(preterit: 'kaufen',
                                       user: @user,
                                       trials: Trial.where(sentence: @sentence))
      verb_practice.verb_and_subject

      expect(verb_practice.verbs_prob.count(@first_verb.id)).to eq 3
      expect(verb_practice.verbs_prob.count(@second_verb.id)).to eq 2
      expect(verb_practice.verbs_prob.count(@third_verb.id)).to eq 1
    end

    it 'removes 2 verb element when 2 trials exist' do
      create_list(:trial, 2, verb: @first_verb, sentence: @sentence,
                             exercice: @exercice, user: @user)

      verb_practice = VerbPractice.new(preterit: 'kaufen',
                                       user: @user,
                                       trials: Trial.where(sentence: @sentence))
      verb_practice.verb_and_subject

      expect(verb_practice.verbs_prob.count(@first_verb.id)).to eq 2
      expect(verb_practice.verbs_prob.count(@second_verb.id)).to eq 2
      expect(verb_practice.verbs_prob.count(@third_verb.id)).to eq 1
    end

    it 'removes all verb element when 4 trials exist' do
      create_list(:trial, 4, verb: @first_verb, sentence: @sentence,
                             exercice: @exercice, user: @user)

      verb_practice = VerbPractice.new(preterit: 'kaufen',
                                       user: @user,
                                       trials: Trial.where(sentence: @sentence))
      verb_practice.verb_and_subject

      expect(verb_practice.verbs_prob.count(@first_verb.id)).to eq 0
      expect(verb_practice.verbs_prob.count(@second_verb.id)).to eq 2
      expect(verb_practice.verbs_prob.count(@third_verb.id)).to eq 1
    end
  end
end
