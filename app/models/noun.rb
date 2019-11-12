class Noun < ApplicationRecord
  has_many :verb_noun_links
  has_many :verbs, through: :verb_noun_links, dependent: :destroy
end
