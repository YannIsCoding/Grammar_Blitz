class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :trials
  has_many :exercices, through: :trials

  validates :username, uniqueness: true

  mount_uploader :photo, PhotoUploader

  def self.wins
    User.find_by_sql("SELECT users.id, COUNT(trials.id) AS trial_count
                      FROM trials
                      INNER JOIN trials ON u.id = trials.user_id
                      where trials.success = true
                      group by users.id
                      ")
  end
end
