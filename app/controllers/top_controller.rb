class TopController < ApplicationController
  def index
    @books = Book.all

  end
end
