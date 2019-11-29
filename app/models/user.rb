class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :progress_trackers, dependent: :destroy
  has_many :trials, through: :progress_trackers

  validates :username, uniqueness: true

  mount_uploader :photo, PhotoUploader
end
