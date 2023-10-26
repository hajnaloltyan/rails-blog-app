class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :comments_counter_updater
  after_destroy :comments_counter_updater
  
  def comments_counter_updater
    post.update(comments_counter: post.comments.count)
  end
end
