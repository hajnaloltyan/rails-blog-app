module Api
  class CommentsController < ApplicationController
    load_and_authorize_resource
    before_action :set_user

    def index
      @post = Post.includes(:comments).find(params[:post_id])
      @comments = @post.comments
      render json: @comments
    end

    def create
      @user = User.find(params[:user_id])
      @post = @user.posts.find(params[:post_id])
      @comment = @post.comments.new(comment_params)
      @comment.user = @user

      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:text)
    end

    def set_user
      @user = User.includes(:posts).find(params[:user_id])
    end
  end
end
