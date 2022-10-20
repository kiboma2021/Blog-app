require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Mexico.', posts_counter: 0)
    @first_user.save
  end

  context 'Validation:' do
    it 'should be valid.' do
      expect(@first_user).to be_valid
    end

    it 'should have name.' do
      test_user = User.new(photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                           posts_counter: 0)
      expect(test_user).to_not be_valid
    end

    it 'should have post.' do
      test_user = User.new(name: 'TOm', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
      expect(test_user).to_not be_valid
    end
    it 'post_counter should be greater than 0' do
      @first_user.posts_counter = -1
      expect(@first_user).to_not be_valid
    end
  end

  context 'Methods:' do
    it 'should return post' do
      first_post = Post.new(author: @first_user, title: 'First post', text: 'First post by first user',
                            comments_counter: 0, likes_counter: 0)
      first_post.save
      post = @first_user.recent_post

      expect(post).to eq([first_post])
    end

    it 'should return recent 3 posts' do
      first_post = Post.new(author: @first_user, title: 'First post', text: 'First post by first user',
                            comments_counter: 0, likes_counter: 0)
      first_post.save
      second_post = Post.new(author: @first_user, title: 'Second post', text: 'Second post by first user',
                             comments_counter: 0, likes_counter: 0)
      second_post.save
      third_post = Post.new(author: @first_user, title: 'Third post', text: 'Third post by first user',
                            comments_counter: 0, likes_counter: 0)
      third_post.save
      fourth_post = Post.new(author: @first_user, title: 'Fourth post', text: 'Fourth post by first user',
                             comments_counter: 0, likes_counter: 0)
      fourth_post.save
      recently_post = @first_user.recent_post
      expect(recently_post).to eq([fourth_post, third_post, second_post])
    end
  end
end
