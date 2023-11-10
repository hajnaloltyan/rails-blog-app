class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_user

  def index
    @posts = @user.posts
  end

  def show
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = Post.new(comments_counter: 0, likes_counter: 0)
  end

  def create
    @post = @user.posts.build(post_params.merge(comments_counter: 0, likes_counter: 0))

    if @post.valid?
      @post.save
      redirect_to user_posts_path(@user)
    else
      Rails.logger.info(@post.errors.full_messages)
      render 'new'
    end
  end

  def destroy
    @post = @user.posts.find(params[:id])
    @post.destroy
    redirect_to user_posts_path(@user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def set_user
    @user = User.includes(:posts).find(params[:user_id])
  end
end
