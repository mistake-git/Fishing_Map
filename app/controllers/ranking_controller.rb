class RankingController < ApplicationController
  
  def fish_size_ranking
      @post = Post.find_by(id: params[:id])
      @posts = Post.where(name: @post.name).where("size IS NOT NULL").order(size: 'DESC').limit(8)
  end
  
end