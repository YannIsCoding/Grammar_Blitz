require 'rails_helper'

RSpec.describe VerbPractice do
  before(:each) do
    @user = create(:user)
    exercice = create(:exercice, structure: 'kaufen_present')
    @sentence = create(:sentence, exercice: exercice, user: @user)
    create(:verb, person: 'third_singular', value: 'kauft')
    create(:pronoun)
    create(:pronoun, person: 'third_masculin', value: 'er')
  end

  describe '#launch' do
    it 'returns true when answer is correct' do
      @sentence = VerbPractice.new(sentence: @sentence).launch

      expect(@sentence.value).not_to be nil
    end

  end
end
