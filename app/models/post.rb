class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :delete_all
  has_many :likes, dependent: :delete_all

  validates :text, presence: true, length: { maximum: 250, minimum: 1 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

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
