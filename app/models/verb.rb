class Verb < ApplicationRecord
  has_many :verb_noun_links, dependent: :destroy
  has_many :nouns, through: :verb_noun_links, dependent: :destroy
end
