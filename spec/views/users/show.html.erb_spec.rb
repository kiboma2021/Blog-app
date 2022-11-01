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
    User.create(
      name: 'Joe',
      photo: 'https://www.pexels.com/photo/cottages-in-the-middle-of-beach-753626/',
      bio: "Sleepy Joe",
      posts_counter: 0
    )
    visit "/users/#{@user.id}"
  end

  it 'displays user profile' do
    expect(page).to have_content(@user.name)
    expect(page).to have_css("img[src*='#{@user.photo}']")
    expect(page).to have_content(@user.posts_counter)
    expect(page).to have_content(@user.bio)
  end


end
