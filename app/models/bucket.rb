class Bucket < ApplicationRecord
  belongs_to :user
  belongs_to :verb

  enum level: %i[zero short long]
end
