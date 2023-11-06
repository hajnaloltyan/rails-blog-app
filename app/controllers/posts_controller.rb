class PostsController < ApplicationController
  def index
    @user = User.includes(:posts).find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.includes(:posts).find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @user = current_user
    @post = Post.new(comments_counter: 0, likes_counter: 0)
  end

  def create
    @user = current_user
    @post = @user.posts.build(post_params.merge(comments_counter: 0, likes_counter: 0))

    if @post.valid?
      @post.save
      redirect_to user_posts_path(@user)
    else
      Rails.logger.info(@post.errors.full_messages)
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
