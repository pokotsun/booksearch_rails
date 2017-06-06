class ReviewController < ApplicationController
  add_breadcrumb 'ホーム', :root
  add_breadcrumb 'レビュー'
  def index
    # @books =  Book.all
    @books = Book.page(params[:page]).per(10).order(:id)
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end

  def show
    @book = Book.find(params[:book_id])
    @read_status = ReadStatus.find_or_create_by(book_id: @book.id)
  end

  def update_read_status
    @read_status = ReadStatus.find_by(book_id: params[:book_id])
    @read_status.update(read_status_params)
    render :update
  end

  def search
    @books = Book.where("title like '%#{params[:book_name]}%'")
    if params["ever-read"] == "true"
      @books = @books.joins(:read_statuses).where("read_statuses.end_date not ?", nil)
    elsif params["ever-read"] == "false"
      @books = @books.joins(:read_statuses).where("read_statuses.end_date is ?", nil)
    end
  end
  def mylist
    @books = Book.all
    @books = @books.joins(:read_statuses).where("read_statuses.favorite not ?", nil)
    render :index
  end
  private
  def read_status_params
    params.require(:read_status).permit(:begin_date, :end_date, :score, :review)
  end
end
