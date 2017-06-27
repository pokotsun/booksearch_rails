class BooksController < ApplicationController
  require 'json'
  require 'net/http'
  require 'uri'
  include AjaxHelper
  add_breadcrumb 'ホーム', :root
  add_breadcrumb 'ISBNコードで探す'
  def index
  end

  def new
    if params[:isbn].nil? or params[:isbn].empty?
      render :new_isbn
    else
      uri = URI.parse("https://www.googleapis.com/books/v1/volumes?q=isbn:#{params[:isbn]}")
      json = Net::HTTP.get(uri)
      result = JSON.parse(json)
      p result
      # p result["totalItems"]
      if result["totalItems"] == 0
        p "book not found"
        respond_to do |format|
          format.html { render :new_isbn }
          format.js { render :not_found_dialog }
        end
      else # ちゃんと結果が帰ってきてたら
        @result = result["items"][0]["volumeInfo"]
        p @result
        # @book = Book.find_by_isbn(@result["industryIdentifiers"][1]["identifier"].to_i)
        @book = Book.find_by(isbn: @result["industryIdentifiers"][1]["identifier"].to_i)
        p "-!-!-!"
        #p @book
        if @book.blank?
          @book = Book.new
          @book.genre_id = 1
          @book.title=@result["title"]
          unless @result["authors"].nil?
            @book.author = @result["authors"][0]
          end
          @book.published_date = @result["publishedDate"]
          @book.page_count = @result["pageCount"]
          @book.description = @result["description"]
          unless @result["imageLinks"].nil?
            @book.image_url = @result["imageLinks"]["thumbnail"]
          end
          @book.isbn = @result["industryIdentifiers"][1]["identifier"]
          @book.save
        end
        @read_status = ReadStatus.find_or_create_by(book_id: @book.id)
        p "book_id #{@book.id}"
        # redirect_to controller: 'review', action: 'show', book_id: @book.id
        respond_to do |format|
          format.js { render ajax_redirect_to("#{review_path}/#{@book.id}") }
        end
      end
    end
  end
  def create

  end

  private
  def book_params
  end
end
