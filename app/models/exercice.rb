class Exercice < ApplicationRecord
  has_many :edicts
  has_many :practice_sessions
  has_many :trials
  has_many :users, through: :trials

  validates :name, :description, presence: true
  validates :name, :description, uniqueness: true

  scope :edicted, -> { where(edicted: true) }
  scope :not_verb, -> { where("structure NOT LIKE ?", "%_present") }
  scope :automated, -> { not_verb.where(edicted: false) }
  scope :with_verb, -> { where("structure LIKE ?", "%_present") }

  def index_mapping
    return [[:subject, 0], [:verb, 1], [:noun, 4]] if structure.edicted?

    case structure.name
    when 's_v_io_do'
      [[:subject, 0], [:verb, 1], [:noun, 3], [:noun, 5]]
    when 'conjug'
      [[:subject, 0]]
    else
      [[:subject, 0], [:verb, 1], [:noun, 3]]
    end
  end

  def preterit
    @preterit ||= structure.split('_').first
  end
end
