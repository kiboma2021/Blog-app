require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /likes' do
    it 'returns http success' do
      get '/users/likes'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /posts' do
    it 'returns http success' do
      get '/users/posts'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /comments' do
    it 'returns http success' do
      get '/users/comments'
      expect(response).to have_http_status(:success)
    end
  end
end
