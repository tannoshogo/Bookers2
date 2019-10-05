class BooksController < ApplicationController
  before_action :authenticate_user!,only: [:create,:edit,:update,:destroy,:index]

  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end
  def edit
    @book = Book.find(params[:id])
  end


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
  if @book.save
    redirect_to @book
  else
    @books = Book.all
    render 'index'
  end
  end
  def update
  @book = Book.find(params[:id])
  if @book.update(book_params)
    flash[:notice] = "Book was successfully updated."
    redirect_to @book

  else
    render 'edit'
  end
end
def destroy
  @book = Book.find(params[:id])
  @book.destroy
  redirect_to books_path
end
private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
