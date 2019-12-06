class PersonalPronoun < ApplicationRecord
  validates :value, inclusion: { in: %w[ich du er sie es wir ihr Sie mich dich ihn uns euch mir dir ihm ihr ihnen],
                                 message: 'Not a valid German personal pronoun' }
  def to_s
   value
  end
end
