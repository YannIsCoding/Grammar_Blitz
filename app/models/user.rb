class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :trials
  has_many :exercices, through: :trials

  validates :username, uniqueness: true

  mount_uploader :photo, PhotoUploader
end
