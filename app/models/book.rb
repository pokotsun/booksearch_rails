class Book < ApplicationRecord
  belongs_to :genre
  has_many :read_statuses 
end
