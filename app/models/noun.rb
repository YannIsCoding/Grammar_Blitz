class Noun < ApplicationRecord
  has_many :verb_noun_links, dependent: :destroy
  has_many :verbs, through: :verb_noun_links, dependent: :destroy

  def to_s
    value.capitalize
  end
end
