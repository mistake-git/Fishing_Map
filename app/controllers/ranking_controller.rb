class RankingController < ApplicationController
  
  def angler_ranking
      @post = Post.find_by(id: params[:id])
      @angler_ranks = User.find(@post.group(:name).order('(size) desc').limit(5).pluck(:name))
  end
  
end