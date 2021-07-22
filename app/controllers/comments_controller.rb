class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
      if @comment.save
        redirect_to post_path(@post), notice: "Your comment was successfully created!"
      else
        redirect_to post_path(@post), alert: "Comment was not created"
      end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), notice: "Your comment was successfully deleted!"
  end
  
  private

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end
