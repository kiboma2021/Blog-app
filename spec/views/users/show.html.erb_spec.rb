require 'rails_helper'

RSpec.describe 'users #show', type: :feature do
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
    Post.create(author: @user, title: 'Title4', text: 'Text4', comments_counter: 0, likes_counter: 0)
  
    visit "/users/#{@user.id}"
  end

  it 'displays user profile' do
    expect(page).to have_content(@user.name)
    expect(page).to have_css("img[src*='#{@user.photo}']")
    expect(page).to have_content(@user.posts_counter)
    expect(page).to have_content(@user.bio)
  end

  it 'displays the users first three posts' do
    recent_posts = @user.recent_post
    recent_posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  it 'Contains a button that shows all posts' do
    expect(page).to have_content('See all posts')
  end

  it 'redirects the user to the complete posts list' do
    click_button('See all posts')
    expect(current_path).to eq("/users/#{@user.id}/posts")
  end

  it 'redirects the user to the post show page' do
    click_link(@user.posts.last.title.to_s)
    expect(current_path).to eq("/users/#{@user.id}/posts/#{@user.posts.last.id}")
  end
end
