require 'rails_helper'

RSpec.describe ExerciceCorrector do
  before(:each) do
    @user = create(:user)
    exercice = create(:exercice)
    @sentence = create(:sentence, exercice: exercice, user: @user)
  end

  describe '#review' do
    it 'returns true when answer is correct' do
      @sentence.value = "Ich bin ein berliner"
      params = ActionController::Parameters.new(response_2: 'ein')

      correction = ExerciceCorrector.new(sentence: @sentence, params: params)
      expect(correction.review).to be true
    end

    it 'returns false when answer is not correct' do
      @sentence.value = "Ich bin ein berliner"
      params = ActionController::Parameters.new(response_2: 'kein')

      correction = ExerciceCorrector.new(sentence: @sentence, params: params)
      expect(correction.review).to be false
    end
  end
end
