class Exercice < ApplicationRecord
  has_many :trials
  has_many :users, through: :trials
  has_many :sentences
  has_many :edicts

  validates :name, :description, presence: true
  validates :name, :description, uniqueness: true
  scope :edicted, -> { where(edicted: true) }


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
end
