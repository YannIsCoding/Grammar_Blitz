require 'rails_helper'

RSpec.describe Sentence, type: :model do
  context "Updating the value, will set the previous value to the #previous_value" do
    it "succesfully" do
      sentence = create(:sentence)
      futur_old_value = sentence.value
      sentence.update(value: "This is a new sentence")

      expect(sentence.previous_value).to eq futur_old_value
      expect(sentence.value).to eq "This is a new sentence"
    end
  end
end
