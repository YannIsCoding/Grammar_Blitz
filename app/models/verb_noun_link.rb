class VerbNounLink < ApplicationRecord
  belongs_to :noun
  belongs_to :verb
end
