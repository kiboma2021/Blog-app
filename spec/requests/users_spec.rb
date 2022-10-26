require 'rails_helper'

RSpec.describe 'Users', type: :request do
  context 'the index method' do
    it 'show all users' do
      get('/users')
      expect(assigns(:users)).to eq(User.all)
    end

    it 'render index template' do
      get('/users')
      expect(response).to render_template('index')
    end

    it 'the veiw body is correct (index)' do
      get('/users')
      expect(response.body).to include('Index of Users list')
    end
  end

  context 'the show method' do
    it 'show specific user veiw' do
      get('/users/1')
      expect(response.body).to include('Specific user info')
    end

    it 'render the correct page' do
      get('/users/1')
      expect(response.body).to render_template('show')
    end
  end
end
