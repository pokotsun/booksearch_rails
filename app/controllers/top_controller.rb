class TopController < ApplicationController
  def index
    @books = Book.all
    @genres = Genre.where.not("id = ?", 1);

    @ever_read_book_count = 0
    @never_read_book_count = 0
    @books.each do |book|
      read_status = ReadStatus.find_or_create_by(book_id: book.id)
      p "read_statusは"+read_status.end_date.to_s
      if read_status.end_date != nil
        @ever_read_book_count+= 1
      else
        @never_read_book_count+= 1
      end
    end

    # スライダーに渡す本の情報
    @ranking_order_books = Book.joins(:read_statuses).includes(:read_statuses).order("read_statuses.score DESC")
    @ever_read_books = Book.joins(:read_statuses).where("read_statuses.end_date not ?", nil)
    @never_read_books = Book.joins(:read_statuses).includes(:read_statuses).where("read_statuses.end_date is ?", nil)

  end

  def search
    @books = Book.page(params[:page]).per(10).order(:id)
    @books = @books.where("title like '%#{params[:book_name]}%'")
  end

end
