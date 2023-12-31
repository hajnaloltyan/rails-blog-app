class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_create :posts_counter_updater
  after_destroy :posts_counter_updater

  def most_recent_comments(limit = 5)
    comments.order(created_at: :asc).limit(limit)
  end

  def posts_counter_updater
    author.update(posts_counter: author.posts.count)
  end

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
