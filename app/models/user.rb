class User < ApplicationRecord
  has_many :practice_sessions
  has_many :trials
  has_many :exercices, through: :trials

  validates :username, uniqueness: true

  after_create :send_welcome_email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :photo, PhotoUploader

  # def corrects
  #   # Trial.where(user: self, result: :correct).count
  #   self.trials.correct
  # end

  def self.ranking
    shameful_array = []
    User.all.each do |user|
      user.successes_count = user.trials.correct_count
      shameful_array << user
    end
    shameful_array.select { |user| user.successes_count.positive? }.sort_by(&:successes_count).reverse!
  end

  private

  def send_welcome_email
    unless Rails.env == 'test'
      UserMailer.welcome(self).deliver_now
    end
  end
end
