class Trial < ApplicationRecord
  belongs_to :atomizable, polymorphic: true, optional: true
  belongs_to :edict, optional: true
  belongs_to :practice_session
  belongs_to :user

  has_one :exercice, through: :practice_session
  has_one :predecessor, class_name: "Trial", foreign_key: "predecessor_id"#, optional: true

  validates_presence_of :practice_session, :user

  enum result: %i[correct wrong]

  scope :completed, -> { where(result: %i[correct wrong]) }
end
