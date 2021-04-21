class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Your post was successfully created!"
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path, notice: "Your post was successfully deleted!"
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post, notice: "Your post was successfully edited!"
    else
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
