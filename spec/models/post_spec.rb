require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) do
    User.create(
      name: 'Hajnalka',
      photo: 'https://i.pravatar.cc/300?img=1',
      bio: 'Photographer',
      posts_counter: 0
    )
  end

  subject do
    Post.new(
      title: 'A Post title',
      text: 'Post has text',
      author_id: user.id,
      comments_counter: 0,
      likes_counter: 0
    )
  end

  it 'is valid with a title within 250 characters and valid counters' do
    expect(subject).to be_valid
  end

  it 'is invalid without a title' do
    subject.title = nil
    subject.valid?
    expect(subject.errors[:title]).to include("can't be blank")
  end

  it 'is invalid with a title exceeding 250 characters' do
    subject.title = 'h' * 251
    subject.valid?
    expect(subject.errors[:title]).to include('is too long (maximum is 250 characters)')
  end

  it 'updates user posts_counter after creation' do
    expect { subject.save }.to change { user.reload.posts_counter }.by(1)
  end

  it 'the CommentsCounter must be an integer' do
    subject.comments_counter = 'a'
    subject.valid?
    expect(subject.errors[:comments_counter]).to include('is not a number')
  end

  it 'the LikesCounter must be an integer' do
    subject.likes_counter = 'a'
    subject.valid?
    expect(subject.errors[:likes_counter]).to include('is not a number')
  end

  it 'returns the five most recent comments' do
    10.times do |i|
      Comment.create(
        text: "Comment - #{i}",
        post: subject,
        user: user
      )
    end

    expect(subject.most_recent_comments.length).to eq(5)
  end
end
