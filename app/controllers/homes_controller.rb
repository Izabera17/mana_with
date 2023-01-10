class HomesController < ApplicationController
  def top
  end

  def home
    @genres = Genre.all
  end

end
