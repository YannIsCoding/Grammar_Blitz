class Exercice < ApplicationRecord
  belongs_to :structure
  has_many :trials
  has_many :users, through: :trials
  has_many :sentences

  validates :name, :description, presence: true
  validates :name, :description, uniqueness: true

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
