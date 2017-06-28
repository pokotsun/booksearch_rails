class Book < ApplicationRecord
  belongs_to :genre
  has_many :read_statuses

  scope :get_paginator_stream, -> (page){ page(page).per(10) }
  scope :ever_read_books, -> (){ joins(:read_statuses).includes(:read_statuses).where.not("read_statuses.end_date is ?", nil) }
  scope :never_read_books, -> (){ joins(:read_statuses).includes(:read_statuses).where("read_statuses.end_date is ?", nil) }

  scope :find_by_title, -> (book_name){where("title like '%#{book_name}%'")}
  scope :get_selected_genre_id_books, -> (){ where("genre_id = ?", @selected_genre_id) }
  scope :get_favo_books, -> (){ joins(:read_statuses).includes(:read_statuses).where("read_statuses.favorite = ?", true) }
  scope :find_by_isbn, ->(isbn){ find_by(isbn: isbn) }
  scope :find_book_by_book_id, ->(book_id){find(book_id)}
  # def get_favo_book2 (a, b)
  #   joins(:read_statuses).where("read_statuses.favorite = ?", true)
  # end
  scope :sort_by_created_at_asc, ->(){ order("books.created_at ASC") }
  scope :sort_by_created_at_desc, ->() { order("books.created_at DESC") }
  scope :sort_by_score_desc, -> { joins(:read_statuses).includes(:read_statuses).order("read_statuses.score DESC") }
  scope :find_by_genre_name, -> { joins(:genre).includes(:genre).order("genres.name DESC")

   }


end
