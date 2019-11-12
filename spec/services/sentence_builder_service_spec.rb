require 'rails_helper'

RSpec.describe SentenceBuilderService do
  sentence = SentenceBuilderService.new 'test'
  result = sentence.generate
  noun = result[:sentence].split.last
  verb = result[:sentence].split.second
  matching_nouns = []
  Verb.find_by(value: verb).nouns.all.each do |noun_instance|
    matching_nouns << noun_instance.value
  end
  it 'verb and noun are matching for S_V_OD' do
    expect(matching_nouns).to include(noun)
  end
end
