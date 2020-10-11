class Verb < ApplicationRecord
  has_many :verb_noun_links, dependent: :destroy
  has_many :nouns, through: :verb_noun_links, dependent: :destroy
  # has_many :sentences, as: :atomizable

  def to_s
    value
  end
end
