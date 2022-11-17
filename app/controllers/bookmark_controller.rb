class BookmarkController < ApplicationController
  before_action :set_list, only: [:destroy]

  def new
    @bookmark = Bookmark.new
  end

  def create
  @bookmark = Bookmark.new(bookmark_params)
  @bookmark.save
  end

  def destroy
    @bookmark.destroy
    # redirect_to bookmarks_url, notice: "Movie has been removed."
  end

  private

  def list_params
    params.require(:bookmark).permit(:comment)
  end

  def set_list
    @bookmark = Bookmark.find(params[:id])
  end
end
