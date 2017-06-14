class Book < ApplicationRecord
  belongs_to :genre
  has_many :read_statuses

  scope :ever_read_books, -> (){ joins(:read_statuses).where.not("read_statuses.end_date is ?", nil) }
  scope :never_read_books, -> (){ joins(:read_statuses).where("read_statuses.end_date is ?", nil) }
  scope :get_ever_or_never_read_books, -> (read_flg) {
    if read_flg == "true"
      ever_read_books
    elsif read_flg == "false"
      never_read_books
    end
  }
  scope :get_favo_books, -> (){ joins(:read_statuses).includes(:read_statuses).where("read_statuses.favorite = ?", true) }
  scope :sort_by_created_at_asc, ->(){ order("books.created_at ASC") }
  scope :sort_by_created_at_desc, ->() { order("books.created_at DESC") }
  scope :find_by_isbn, ->(isbn){ find_by(isbn: isbn) }
  # def get_favo_book2 (a, b)
  #   joins(:read_statuses).where("read_statuses.favorite = ?", true)
  # end
  scope :sort_by_score_desc, -> { joins(:read_statuses).includes(:read_statuses).order("read_statuses.score DESC") }


end
