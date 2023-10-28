require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      name: 'Hajnalka',
      photo: 'https://i.pravatar.cc/300?img=1',
      bio: 'Photographer',
      posts_counter: 0
    )
  end

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'is invalid without a name' do
    subject.name = nil
    subject.valid?
    expect(subject.errors[:name]).to include("can't be blank")
  end

  it 'is invalid with a posts_counter less than 0' do
    subject.posts_counter = -1
    subject.valid?
    expect(subject.errors[:posts_counter]).to include('must be greater than or equal to 0')
  end

  it 'is invalid with a posts_counter not an integer' do
    subject.posts_counter = 'a'
    subject.valid?
    expect(subject.errors[:posts_counter]).to include('is not a number')
  end
end
