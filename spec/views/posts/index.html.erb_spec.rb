require 'rails_helper'

RSpec.describe 'posts #index', type: :feature do
  before :each do
    @user = User.create(
      name: 'Ben',
      photo: 'https://www.pexels.com/photo/cottages-in-the-middle-of-beach-753626/',
      bio: "I'm finding it hard coping with ruby on rails especially where it involves Pagination",
      posts_counter: 0
    )
    Post.create(author: @user, title: 'Title', text: 'Text', comments_counter: 0, likes_counter: 0)
    Post.create(author: @user, title: 'Title2', text: 'Text2', comments_counter: 0, likes_counter: 0)
    Post.create(author: @user, title: 'Title3', text: 'Text3', comments_counter: 0, likes_counter: 0)
    @post = Post.create(author: @user, title: 'Title4', text: 'Text4', comments_counter: 0, likes_counter: 0)
    User.create(
      name: '1st',
      photo: 'https://www.pexels.com/photo/silhouette-of-a-person-on-a-swing-3293148/',
      bio: "I'm a student at Microverse",
      posts_counter: 0
    )
    visit "/users/#{@user.id}"
  end

  it 'displays user info' do
    expect(page).to have_content(@user.name)
    expect(page).to have_css("img[src*='#{@user.photo}']")
    expect(page).to have_content(@user.posts_counter.to_s)
  end

  it 'can display a post title' do
    expect(page).to have_content(@post.title)
  end

  it 'can display a post body' do
    expect(page).to have_content(@post.text)
  end

  it 'displays the first comments in a post' do
    comments = @post.comments
    comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end

  it 'displays the number of comments in a post' do
    expect(page).to have_content(@post.comments_counter)
  end

  it 'displays the number of likes in a post' do
    expect(page).to have_content(@post.likes_counter)
  end

  it 'shows the Pagination button' do
    expect(page.body).to include('Pagination')
  end

  it 'redirects the user to the post show page' do
    click_link(@post.title)
    expect(current_path).to eq("/users/#{@user.id}/posts/#{@post.id}")
  end
end
