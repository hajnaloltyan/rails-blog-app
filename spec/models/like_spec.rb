require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) do
    User.create(
      name: 'Hajni',
      photo: 'https://i.pravatar.cc/300?img=1',
      bio: 'Photographer',
      posts_counter: 0
    )
  end

  let(:post) do
    Post.create(
      title: 'A post title',
      text: 'A post text',
      author: user,
      comments_counter: 0,
      likes_counter: 0
    )
  end

  subject do
    Like.new(
      user:,
      post:
    )
  end

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'is invalid without a user_id' do
    subject.user = nil
    subject.valid?
    expect(subject.errors[:user]).to include('must exist')
  end

  it 'is invalid without a post_id' do
    subject.post = nil
    subject.valid?
    expect(subject.errors[:post]).to include('must exist')
  end
end
