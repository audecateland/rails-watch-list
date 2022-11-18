class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:destroy]
  before_action :set_list, only: %i[new create]

  def new
    @bookmark = Bookmark.new
    # set_list se joue et permet de rechercher l'id de la liste au traver de la route nested que l'on a créé et donc de lier le bookmark et la liste. Désormais on a accès à la variable @list correspondante.
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    # D'abord la méthode pour retrouver la liste sur laquelle on est (url) est appelée et stockée dans une variable via la méthode set_list. La ligne suivante on attribue le champ list_id
    @bookmark.list_id = @list.id
    # avec rails on écrit aussi en simplifié @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Méthode destroy se fait sur l url /boormarks
  def destroy
    # set_bookmark est appelée
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
    # on ajoute dans le permit tout ce qu'on met dans le formulaire
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
