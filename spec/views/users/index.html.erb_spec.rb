require 'rails_helper'

RSpec.describe 'users #index', type: :feature do
    before :each do
      user1 = User.create(
        name: 'Ben',
        photo: 'https://www.pexels.com/photo/cottages-in-the-middle-of-beach-753626/',
        bio: "I'm finding it hard coping with ruby on rails",
        posts_counter: 0
      )
      user2 = User.create(
        name: 'Samson',
        photo: 'https://www.pexels.com/photo/a-rocky-shore-under-clear-blue-sky-8821913/',
        bio: "I'm love coding using python",
        posts_counter: 0
      )
      @users = [user1, user2]
      visit '/users'
    end
  
    it 'displays all users cards' do
      @users.each do |user|
        expect(page).to have_content(user.name)
        expect(page).to have_css("img[src*='#{user.photo}']")
        expect(page).to have_content(user.posts_counter)
      end
    end
  
  end