class LikesController < ApplicationController
  load_and_authorize_resource
  def new
    @like = Like.new
  end

  def create
    @user = User.includes(:posts).find(params[:user_id])
    @post = Post.includes(:likes).find(params[:post_id])
    @like = @post.likes.build(user: @user, post: @post)

    if @like.valid?
      @like.save
      redirect_to user_post_path(@user, @post)
    else
      Rails.logger.info(@like.inspect)
    end
  end
end
