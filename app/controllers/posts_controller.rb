class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post, only: [:show, :destroy, :edit, :update]
  def index
    @posts = Post.all
  end
  
  def show
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
    @post.destroy

    redirect_to root_path, notice: "Your post was successfully deleted!"
  end

  def edit
  end

  def update
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

    def find_post
      @post = Post.find(params[:id])
    end
end
