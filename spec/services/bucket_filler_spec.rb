require 'rails_helper'

RSpec.describe BucketFiller do
  before(:each) do
    @user = create(:user)
    exercice = create(:exercice)
    @sentence = create(:sentence, exercice: exercice, user: @user)

    @first_verb = create(:verb)
    @second_verb = create(:verb, value: 'kauft', person: 'third_singular')
    @third_verb = create(:verb, value: 'kaufen', person: 'first_plurial')

    create(:trial, verb: @first_verb, sentence: @sentence,
                   exercice: exercice, user: @user)
    create(:trial, result: :success, verb: @second_verb, sentence: @sentence,
                   exercice: exercice, user: @user)
    create(:trial, result: :success, verb: @third_verb, sentence: @sentence,
                   exercice: exercice, user: @user)

    create(:bucket, user: @user, level: :short, verb: @third_verb)
  end

  describe 'Fills the bucket' do
    it 'succesfully' do
      BucketFiller.new(Trial.where(sentence: @sentence)).go

      first_bucket = Bucket.find_by(user: @user, verb: @first_verb)
      second_bucket = Bucket.find_by(user: @user, verb: @second_verb)
      third_bucket = Bucket.find_by(user: @user, verb: @third_verb)
      expect(first_bucket.zero?).to be true
      expect(second_bucket.short?).to be true
      expect(third_bucket.long?).to be true
    end
  end
end
