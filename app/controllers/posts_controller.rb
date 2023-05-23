class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post, only: [:show, :destroy, :edit, :update, :like]

  def index
     @posts = Post.paginate(page: params[:page], per_page: 10).order('created_at DESC')
     @popular_posts = Post.popular_posts.limit(25)
  end
  
  def show
    @comment = @post.comments.build
    @comments = @post.comments.includes(:user).paginate(page: params[:page], 
                                                        per_page: 10).order('created_at DESC')
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

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Your post was successfully edited!"
    else
      render :edit
    end
  end

  def like
    if @post.liked?(current_user) 
      @post.unlike(current_user)
    else
      @post.like(current_user)
    end

    redirect_to @post
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

    def find_post
      @post = Post.find(params[:id])
    end
end
