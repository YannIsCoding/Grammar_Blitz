class Trial < ApplicationRecord
  belongs_to :user
  belongs_to :exercice # TODO: remove
  belongs_to :sentence
  belongs_to :verb, optional: true # TODO: remove, redudant atomizable
  belongs_to :edict, optional: true
  belongs_to :atomizable, polymorphic: true, optional: true

  has_one :predecessor, class_name: "Trial", foreign_key: "predecessor_id"#, optional: true

  validates_presence_of :exercice, :sentence, :user

  enum result: %i[correct wrong]

  scope :completed, -> { where(result: %i[correct wrong]) }
end
