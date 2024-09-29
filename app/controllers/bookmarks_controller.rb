class BookmarksController < ApplicationController
  before_action :set_movie, only: [:create, :new]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(comment: bookmark_params[:comment])
    @list = List.find(bookmark_params[:list])
    @bookmark.list = @list
    @bookmark.movie = @movie
    if @bookmark.save
      redirect_to list_path(@bookmark.list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to @bookmark.list, status: :see_other
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :list)
  end
end
