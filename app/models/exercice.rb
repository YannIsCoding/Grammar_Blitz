class Exercice < ApplicationRecord
  has_many :edicts
  has_many :practice_sessions
  has_many :trials, through: :practice_sessions
  # has_many :users, through: :trials

  validates :name, :description, presence: true
  validates :name, :description, uniqueness: true

  scope :published, -> { where(published: true) }
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

  def correct_trials_count(user)
    @correct_trials_count ||= trials.where(user: user)
                                    .where("trials.created_at >= :week_start AND trials.created_at <= :week_end",
                                           week_start: DateTime.current.beginning_of_week,
                                           week_end: DateTime.current.end_of_week)
                                    .where(result: 'correct')
                                    .count
  end

  def total_trials_count(user)
    @total_trials_count = trials.where(user: user)
                                .where("trials.created_at >= :week_start AND trials.created_at <= :week_end",
                                       week_start: DateTime.current.beginning_of_week,
                                       week_end: DateTime.current.end_of_week)
                                .count
  end

  def percentage_correct(user)
    @percentage_correct ||= ((correct_trials_count(user).to_f / total_trials_count(user)) * 100).round
  end

  def total_points(user)
    correct_trials_count(user) * 84
  end

  def successful?(user)
    percentage_correct(user) > 80
  end
end
