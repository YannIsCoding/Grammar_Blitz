require 'rails_helper'

RSpec.describe VerbPractice do
  before(:each) do
    @user = create(:user)
    @exercice = create(:exercice, structure: 'kaufen_present')
    verb = create(:verb, person: 'third_singular', value: 'kauft')
    @sentence = create(:sentence, exercice: @exercice, user: @user, atomizable: verb)
    create(:pronoun)
    create(:pronoun, person: 'third_masculin', value: 'er')
  end

  describe '#launch' do
    it 'update the sentence and create a trial' do
      VerbBuilder.any_instance.stub(:generate).and_return(value: 'ich bin',
                                                          english: 'I am')

      @sentence = VerbPractice.new(sentence: @sentence).launch

      expect(@sentence.value).to eq 'ich bin'
      expect(@sentence.session_counter).to be 1
      expect(Trial.count).to be 0
    end
  end

  describe '#continue' do
    it 'update the sentence, update trial and create a new one when wrong' do
      old_trial = create(:trial, result: :correct, exercice: @exercice, sentence: @sentence)
      VerbBuilder.any_instance.stub(:generate).and_return(value: 'ich bin',
                                                          english: 'I am')

      @sentence = VerbPractice.new(sentence: @sentence).continue(:wrong)

      expect(@sentence.value).to eq 'ich bin'
      expect(@sentence.session_counter).to be 1
      expect(Trial.count).to be 2
      expect(Trial.last.wrong?).to be true
      expect(old_trial.reload.correct?).to be true
    end

    it 'update the sentence, update trial and create a new one when correct' do
      old_trial = create(:trial, result: :wrong, exercice: @exercice, sentence: @sentence)
      VerbBuilder.any_instance.stub(:generate).and_return(value: 'ich bin',
                                                          english: 'I am')

      @sentence = VerbPractice.new(sentence: @sentence).continue(:correct)

      expect(@sentence.value).to eq 'ich bin'
      expect(@sentence.session_counter).to be 1
      expect(Trial.count).to be 2
      expect(Trial.last.correct?).to be true
      expect(old_trial.reload.wrong?).to be true
    end
  end
end
