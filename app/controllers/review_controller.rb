class ReviewController < ApplicationController
  protect_from_forgery except: [:update_favorite]
  add_breadcrumb 'ホーム', :root
  add_breadcrumb 'レビュー'
  def index
    @books = Book.page(params[:page]).per(10).order(:id)
    @genres = Genre.where.not("id = ?", 1)
    @selected_genre_id = params[:genre_id] || "1"
    selected_name = params[:search_name] || ""
    @favorite_flg = params[:favorite]||"false"
    if @favorite_flg == "true"
      @books = @books.get_favo_books
    end
    if selected_name != ""
      @books = @books.where("title like '%#{selected_name}%'")
    end
    if @selected_genre_id != "1"
      @books = @books.where("genre_id = ?", @selected_genre_id)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @book = Book.find(params[:book_id])
    @read_status = ReadStatus.find_or_create_by(book_id: @book.id)
    @genres = Genre.where.not("id = ?", 1)
  end

  def update_read_status
    @book = Book.find(params[:book_id])
    @read_status = ReadStatus.find_by(book_id: params[:book_id])
    @read_status.update(read_status_params)
    @book.genre_id = params[:book_genre] unless params[:book_genre].nil?
    @book.save
    render :update
  end

  def search
    @books = Book.page(params[:page]).per(10).order(:id)
    @books = @books.where("title like '%#{params[:book_name]}%'")
    # @books = Book.get_ever_or_never_read_books(params["ever_read"])
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
    if params["order"].present?
      if params["order"] == "1"
        @books = @books.sort_by_created_at_asc
      elsif params["order"] == "2"
        @books = @books.sort_by_created_at_desc
      elsif params["order"] == "3"
        @books = @books.sort_by_score_desc
      else
        @books = @books.joins(:genre).includes(:genre).order("genres.name DESC")
      end
    end
  end

  def update_favorite
    @read_status = ReadStatus.find(params[:id])
    p "-!-!-!"
    p "params = "+ params[:id]
    @read_status.update(favorite: !@read_status.favorite)
  end

  private
  def read_status_params
    params.require(:read_status).permit(:begin_date, :end_date, :score, :review)
  end
end
