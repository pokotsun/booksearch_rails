class Genre < ApplicationRecord
  has_many :books

  scope :get_genres_except_default, -> (){ where.not("id = ?", 1) }
end
