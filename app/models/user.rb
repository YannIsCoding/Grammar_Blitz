class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :trials
  has_many :exercices, through: :trials

  validates :username, uniqueness: true

  mount_uploader :photo, PhotoUploader

  # def self.wins
  #   ActiveRecord::Base.connection.execute("select users.*, sum(case when trials.success = true then 1 else 0 end) as successful_trials
  #                     from users
  #                     left join trials on users.id = trials.id
  #                     group by users.id
  #                     order by successful_trials desc
  #                     ")
  # end

  def successes
    Trial.where(user: self, success: true).count
  end

  def self.ranking
    shameful_array = []
    User.all.each do |user|
      user.successes_count = user.successes
      shameful_array << user
    end
    shameful_array.sort_by(&:successes_count).reverse!
  end
end
