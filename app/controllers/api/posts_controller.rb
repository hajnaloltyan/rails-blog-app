module Api
  class PostsController < ApplicationController
    load_and_authorize_resource
    before_action :set_user

    def index
      @posts = @user.posts
      render json: @posts
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def set_user
    @user = User.includes(:posts).find(params[:user_id])
  end
end
