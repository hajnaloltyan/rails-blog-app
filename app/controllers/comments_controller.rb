class CommentsController < ApplicationController
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    
    if @comment.valid?
      @comment.save
      redirect_to user_post_path(@user.id, @post.id)
    else
      Rails.logger.info(@comment.errors.full_messages)
      render 'new'
    end
  end

  private

  def post_params
    params.require(:comment).permit(:text)
  end
end
