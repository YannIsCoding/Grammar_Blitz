require 'rails_helper'

RSpec.describe SentenceBuilder, type: :module do
  it '#subject_verb should return a string' do
    expect(SentenceBuilder.subject_verb('first_singular', 'first_singular')).to be_an_instance_of(String)
  end

  it '#subject_verb should return the matching subject and verb' do
    expect(SentenceBuilder.subject_verb('first_singular', 'first_singular')).to eq('ich bin')
    expect(SentenceBuilder.subject_verb('third_feminin', 'third_singular')).to eq('sie ist')
    expect(SentenceBuilder.subject_verb('second_plurial', 'second_plurial')).to eq('ihr seid')
  end

  it '#article_noun should return a string' do
    options = { gender: 'feminin', case: 'nominative', definite: true }
    expect(SentenceBuilder.article_noun(options)).to be_an_instance_of(String)
  end

  it '#article_noun should match the given parameter' do
    options = [
      { gender: 'feminin', case: 'nominative', definite: true },
      { gender: 'plurial', case: 'nominative', definite: true },
      { gender: 'masculin', case: 'nominative', definite: true },
      { gender: 'neutral', case: 'nominative', definite: true },
    ]
    options.each do |option|
      result = SentenceBuilder.article_noun(option).split
      articles = Article.where(option)
      noun = Noun.where(value: result[1]).first
      expect(result[0]).to eq(articles.first.value)
      expect(noun.gender).to eq(option[:gender])
    end
  end
end
