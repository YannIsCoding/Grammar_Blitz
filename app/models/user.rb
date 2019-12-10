class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :trials
  has_many :exercices, through: :trials
  has_many :sentences

  validates :username, uniqueness: true

  mount_uploader :photo, PhotoUploader

  def successes
    Trial.where(user: self, success: true).count
  end

  def self.ranking
    shameful_array = []
    User.all.each do |user|
      user.successes_count = user.successes
      shameful_array << user
    end
    shameful_array.select { |user| user.successes.positive? }.sort_by(&:successes_count).reverse!
  end
end
