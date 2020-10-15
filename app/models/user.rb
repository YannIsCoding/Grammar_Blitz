class User < ApplicationRecord
  has_many :practice_sessions
  has_many :trials
  has_many :exercices, through: :trials

  validates :username, uniqueness: true

  after_create :send_welcome_email

  scope :ranking, -> { where("successes_count > '0'").order(successes_count: :desc) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :photo, PhotoUploader

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now unless Rails.env == 'test'
  end
end
