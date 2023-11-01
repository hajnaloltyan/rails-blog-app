require 'rails_helper'

RSpec.describe "UsersControllers", type: :request do
  describe "GET /index" do
    it 'returns a successful response' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('List of all Users')
    end
  end

  describe "GET /show" do
    before do
      @user = User.create(name: 'Hajnal Oltyan', photo: 'https://via.placeholder.com/150', bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', posts_counter: 0)
    end

    it 'returns a successful response' do
      get user_path(@user.id)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_path(@user.id)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_path(@user.id)
      expect(response.body).to include('User\'s Profile')
    end
  end
end
