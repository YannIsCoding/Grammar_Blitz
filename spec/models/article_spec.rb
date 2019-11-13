require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'sould have all it attributes' do
    expect(Article.first).to respond_to(:value)
    expect(Article.first).to respond_to(:gender)
    expect(Article.first).to respond_to(:g_case)
    expect(Article.first).to respond_to(:definite)
  end
end
