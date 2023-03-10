class GenresController < ApplicationController
  before_action :genre_all, only: [:index, :edit, :destroy, :update] 
  before_action :ensure_correct_genre, only: [:edit]
  
  def index
    @genre = Genre.new
    @genres = Genre.page(params[:page]).per(8)
  end
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "ジャンルを追加しました"
      redirect_to genres_path
    else
      flash[:alert] = "追加できませんでした"
      @genres = Genre.all
      redirect_to genres_path
    end
  end

  def edit
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "変更を保存しました"
      redirect_to genres_path
    else
      flash[:alert] = "変更を保存できませんでした"
      render 'edit'
    end
  end
  
  def destroy
    @genre = Genre.find(params[:id])  
    @genre.destroy
    flash[:notice] = "ジャンルを削除しました"
    redirect_to genres_path
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
  
  def genre_all
    @genres = Genre.all
  end

   def ensure_correct_genre
    begin
      @genre = Genre.find(params[:id])
    rescue
      flash[:alert] = "入力されたジャンルは存在しません"
      redirect_to genres_path
    else
    end
  end

end