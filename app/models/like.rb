class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :likes_counter_updater
  after_destroy :likes_counter_updater

  def likes_counter_updater
    post.update(likes_counter: post.likes.count)
  end
end
