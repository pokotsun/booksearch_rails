class ReviewController < ApplicationController
  add_breadcrumb 'ホーム', :root
  add_breadcrumb 'レビュー'
  def index
    @books = Book.get_paginator_stream(params[:page])
    @genres = Genre.get_genres_except_default
    @selected_genre_id = params[:genre_id] || "1"
    @favorite_flg = params[:favorite]||"false"
    ever_read_flg = params[:ever_read]

    if @favorite_flg == "true"
      @books = @books.get_favo_books
    end
    if @selected_genre_id != "1"
      @books = @books.where("genre_id = ?", @selected_genre_id)
    end
    if ever_read_flg != "nil"
      if ever_read_flg == "true"
        @books = @books.ever_read_books
      else
        @books = @books.never_read_books
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @book = Book.find_book_by_book_id(params[:book_id])
    @read_status = ReadStatus.get_or_create_read_status(@book.id)
    @genres = Genre.get_genres_except_default
  end

  def update_read_status
    @book = Book.find_book_by_book_id(params[:book_id])
    @read_status = ReadStatus.get_read_status(@book.id)
    @read_status.update(read_status_params)
    @book.genre_id = params[:book_genre]
    @book.save
    render :update
  end


  # def search_by_name
  #   @books = Book.where("title like '%#{params[:book_name]}'%")
  #   if @books.count > 0
  #     respond_to do |format|
  #       format.html { render :  }
  #       format.js { render :not_found_dialog }
  #   else
  #     respond_to do |format|
  #       format.html { render : }
  #       format.js { render :not_found_dialog }
  #     end
  #
  #   end
  # end

  def search
    @books = Book.get_paginator_stream(params[:page])
    @books = @books.find_by_title(params[:book_name])
    # @books = @books.get_ever_or_never_read_books(params["ever_read"])
    if params["ever-read"] == "true"
      @books = @books.ever_read_books
    elsif params["ever-read"] == "false"
      @books = @books.never_read_books
    end
    if params["favorite"] =="on"
      @books = @books.get_favo_books
    end
    unless params[:genres].nil?
      flg = true
      params[:genres].each do |genre_id|
        @books = @books.or(Book.where("genre_id = ?", genre_id.to_i)) unless flg
        @books = @books.where("genre_id = ?", genre_id) if flg
        flg = false
      end
    end
    order = params[:order]
    if order.present?
      if order == "1"
        @books = @books.sort_by_created_at_asc
      elsif order == "2"
        @books = @books.sort_by_created_at_desc
      elsif order == "3"
        @books = @books.sort_by_score_desc
      elsif order == 4
        @books = @books.find_by_genre_name
      end
    end
  end

  private
  def read_status_params
    params.require(:read_status).permit(:begin_date, :end_date, :score, :review, :favorite)
  end
end
