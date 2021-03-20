class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.save!
    redirect_to @comment.post
  end

  def comment_params
    params.require(:comment).permit(:body, :author_id, :post_id)
  end
end
