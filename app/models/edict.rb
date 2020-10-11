class Edict < ApplicationRecord
  belongs_to :exercice
  has_many :trials, dependent: :destroy

  validates :value, :english, uniqueness: true

  after_initialize :set_hide_index

  private

  def set_hide_index
    # set default value
    unless persisted?
      assign_attributes(hide_index: exercice&.hide_index)
    end
  end

end
