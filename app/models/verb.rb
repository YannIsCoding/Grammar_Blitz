class Verb < ApplicationRecord
  has_many :verb_noun_links
  has_many :nouns, through: :verb_noun_links, dependent: :destroy
end
