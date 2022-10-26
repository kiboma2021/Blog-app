class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author: @user)

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.find_by(id: params[:id], author_id: params[:user_id])
    @comments = @post.most_recent_comments

    respond_to do |format|
      format.html
      format.json { render json: @post.comments }
    end
  end
end
