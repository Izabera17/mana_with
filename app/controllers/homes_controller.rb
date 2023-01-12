class HomesController < ApplicationController
  def top
  end

  def home
    @genres = Genre.all
    @post_learnings = PostLearning.all.order(created_at: :desc)
  end
end
