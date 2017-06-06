class ReadStatus < ApplicationRecord
  belongs_to :book
  scope :ever_read, -> {where.not(end_date: nil)}
  scope :never_read, -> {where(end_date: nil)}
end
