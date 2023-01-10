class HomesController < ApplicationController
  def top
  end

  def home
    @genres = Genre.all
    @post_learnings = PostLearning.all
  end
end
