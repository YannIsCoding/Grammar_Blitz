class Article < ApplicationRecord
  validates :value, inclusion: { in: %w[der die das den dem ein eine einen einem einer],
                                 message: "Not a  valid German article" }
end
