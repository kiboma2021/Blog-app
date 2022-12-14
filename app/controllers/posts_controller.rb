class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author: @user)

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = current_user
    @comms = @post.comments.includes(:author)

    respond_to do |format|
      format.html
      format.json { render json: @post.comments }
    end
  end

  def new
    @post = Post.new
    @user = current_user
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    author = current_user
    post = Post.new(params.require(:post).permit(:comments_counter, :likes_counter, :author, :title, :text))
    post.likes_counter = 0
    post.comments_counter = 0
    post.author = author

    respond_to do |format|
      format.html do
        if post.save
          flash[:success] = 'Post created successfully!'
          redirect_to user_url(author)
        else
          flash.now[:error] = 'Error: Post could not be created.'
        end
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to user_posts_url }
      format.json { head :no_content }
    end
  end
end
