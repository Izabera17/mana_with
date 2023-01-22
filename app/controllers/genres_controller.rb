class GenresController < ApplicationController
  before_action :genre_all, only: [:index, :edit] 
  
  def index
    @genre = Genre.new
    @genres = Genre.page(params[:page]).per(8)
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genres_path
    else
      @genres = Genre.all
      render 'index'
    end
  end

  def edit
    @genre = Genre.find(params[:id])
    @genres = Genre.all
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to genres_path
    else
    render 'edit'
    end
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
  
  def genre_all
    @genres = Genre.all
  end

end