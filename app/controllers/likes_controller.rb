class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: @user, post: @post)
    
    if @like.valid?
      @like.save
      redirect_to user_post_path(@user, @post)
    else
      Rails.logger.info(@like.inspect)
    end
  end
end
