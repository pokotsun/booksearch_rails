class ReadStatus < ApplicationRecord
  belongs_to :book
  scope :ever_read, -> {where.not(end_date: nil)}
  scope :never_read, -> {where(end_date: nil)}
  scope :sort_by_score_desc, -> { joins(:read_statuses).order("read_statuses.score DESC") }
  scope :get_or_create_read_status, -> (book_id){ find_or_create_by(book_id: book_id) }
  scope :get_read_status, -> (book_id){ find_by(book_id: book_id) }
end
