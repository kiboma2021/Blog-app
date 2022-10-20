class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :update_post_comment_counter
  def update_post_comment_counter
    post.comments_counter = 0 unless post.comments_counter?
    post.comments_counter += 1
    post.save
  end
end
