require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Mexico.', posts_counter: 0)
    @first_user.save

    @first_post = Post.new(author: @first_user, title: 'First post', text: 'First post by first user',
                           comments_counter: 0, likes_counter: 0)
    @first_post.save

    @first_comment = Comment.create(author: @first_user, post: @first_post, text: 'First Comment for first post')
    @first_comment.save
  end

  context 'Methods:' do
    it 'should update comment counter.' do
      prev_comments = @first_post.comments_counter
      @first_comment.update_post_comment_counter

      comments_counter = @first_post.comments_counter

      expect(comments_counter).to be prev_comments + 1
    end
  end
end
