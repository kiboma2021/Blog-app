require 'rails_helper'

RSpec.describe 'posts #show', type: :feature do
  before :each do
    @user = User.create(
      name: 'Benson',
      photo: 'https://www.pexels.com/photo/cottages-in-the-middle-of-beach-753626/',
      bio: "I'm finding it hard coping with ruby on rails",
      posts_counter: 0
    )
    Post.create(author: @user, title: 'Title', text: 'Text', comments_counter: 0, likes_counter: 0)
    Post.create(author: @user, title: 'Title2', text: 'Text2', comments_counter: 0, likes_counter: 0)
    Post.create(author: @user, title: 'Title3', text: 'Text3', comments_counter: 0, likes_counter: 0)
    @post = Post.create(author: @user, title: 'Title4', text: 'Text4', comments_counter: 0, likes_counter: 0)

    visit "/users/#{@user.id}/posts/#{@post.id}"
  end

  describe 'post show page' do
    it 'shows the post\'s title' do
      expect(page).to have_content(@post.title)
    end

    it 'shows who wrote the post' do
      expect(page).to have_content(@user.name)
    end

    it 'shows number of comments the post has' do
      expect(page.body).to include('Number of comments')
    end

    it 'shows number of likes the post has' do
      expect(page.body).to include('Number of likes')
    end

    it 'shows the post body' do
      expect(page).to have_content(@post.text)
    end

    it 'shows all comments and the author name' do
      comments = @post.comments
      comments.each do |comment|
        expect(page).to have_content(comment.author.name)
        expect(page).to have_content(comment.text)
      end
    end
  end
end
