class BooksController < ApplicationController

before_action :authenticate_user!

  def index
    @book2 = Book.new
    @books = Book.all
  end

  def show
    @book2 = Book.new
    @book = Book.find(params[:id])
  end

  def create
    @book2 = Book.new(book_params)
    @book2.user_id = current_user.id
    if @book2.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book2)
    else
      flash[:notice] = "error"
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user.id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      flash[:notice] = "error"
      @book = Book.find(params[:id])
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
end

end
