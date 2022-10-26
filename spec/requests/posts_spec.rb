require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  context 'the index method' do
    it 'show all users' do
      get('/users/10/posts')
      expect(assigns(:posts)).to eq(Post.all)
    end

    it 'render index template' do
      get('/users/10/posts')
      expect(response).to render_template('index')
    end

    it 'the veiw body is correct (index)' do
      get('/users/10/posts')
      expect(response.body).to include('Index for user posts')
    end
  end

  context 'the show method' do
    it 'show specific user post veiw' do
      get('/users/403/posts/1')
      expect(response.body).to include('spesific user post')
    end

    it 'render the correct page' do
      get('/users/403/posts/1')
      expect(response.body).to render_template('show')
    end
  end
end
