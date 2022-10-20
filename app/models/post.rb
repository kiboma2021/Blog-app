class Post < ApplicationRecord
    belongs_to :author, class_name: 'User'
    has_many :comments, dependent: :delete_all
    has_many :likes, dependent: :delete_all

    after_create :update_posts_count
    def update_posts_count
      author.posts_counter = 0 unless author.posts_counter?
      author.posts_counter += 1
      author.save
    end
  
    def most_recent_comments
      Comment.includes(:author).where(post: self).order(created_at: :desc).limit(5)
    end
end
  