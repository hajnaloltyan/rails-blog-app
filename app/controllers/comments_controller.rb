class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_user

  def index
    @post = Post.includes(:comments).find(params[:post_id])
    @comments = @post.comments
  end

  def show
    @post = Post.includes(:comments).find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def new
    @post = Post.includes(:comments).find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.includes(:comments).find(params[:post_id])
    @comment = @post.comments.build(comment_params.merge(user: @user, post: @post))

    if @comment.valid?
      @comment.save
      redirect_to user_post_path(@user, @post)
    else
      Rails.logger.info(@comment.errors.full_messages)
      render 'new'
    end
  end

  def destroy 
    @post = Post.includes(:comments).find(params[:post_id])
    @comment = Comment.includes(:user, :post).find(params[:id])
    @comment.destroy
    redirect_to user_post_path(@user, @post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_user
    @user = User.includes(:posts).find(params[:user_id])
  end
end
