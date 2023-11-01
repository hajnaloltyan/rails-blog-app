require 'rails_helper'

RSpec.describe "PostsControllers", type: :request do
  describe "GET /index" do
    before do
      @user = User.create(name: 'Hajnal Oltyan', photo: 'https://via.placeholder.com/150', bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', posts_counter: 0)
      @post = Post.create(title: 'Lorem ipsum', text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', author_id: @user.id)
    end

    it 'returns a successful response' do
      get user_posts_path(@user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get user_posts_path(@user)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get user_posts_path(@user)
      expect(response.body).to include('List of all User\'s Posts')
    end
  end

  describe "GET /show" do
    before do
      @user = User.create(name: 'Hajnal Oltyan', photo: 'https://via.placeholder.com/150', bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', posts_counter: 0)
      @post = @user.posts.create!(title: 'Lorem ipsum', text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', author_id: @user.id, comments_counter: 0, likes_counter: 0)
    end

    it 'returns a successful response' do
      get user_post_path(@user.id, @post.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_post_path(@user.id, @post.id)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_post_path(@user.id, @post.id)
      expect(response.body).to include('Selected Post')
    end
  end
end
