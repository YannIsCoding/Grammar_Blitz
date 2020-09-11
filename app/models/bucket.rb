class Bucket < ApplicationRecord
  belongs_to :user
  belongs_to :verb

  enum level: %i[blank short long]
end
