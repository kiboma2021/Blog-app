require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Mexico.', posts_counter: 0)
    @first_user.save

    @first_post = Post.new(author: @first_user, title: 'First post', text: 'First post by first user',
                           comments_counter: 0, likes_counter: 0)
    @first_post.save
  end

  context 'Methods:' do
    it 'should Update like' do
      new_like = Like.create(author: @first_user, post: @first_post)
      new_like.save
      like = @first_post.likes_counter
      expect(like).to be 1
    end
  end
end
