class CommentsController < ApplicationController
  def new
    @user = current_user
    @post = Post.includes(:comments).find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
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

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
