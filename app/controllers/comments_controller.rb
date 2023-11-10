class CommentsController < ApplicationController
  def new
    @user = User.includes(:posts).find(params[:user_id])
    @post = Post.includes(:comments).find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = User.includes(:posts).find(params[:user_id])
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
    @user = User.includes(:posts).find(params[:user_id])
    @post = Post.includes(:comments).find(params[:post_id])
    @comment = Comment.includes(:user, :post).find(params[:id])
    @comment.destroy
    redirect_to user_post_path(@user, @post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
