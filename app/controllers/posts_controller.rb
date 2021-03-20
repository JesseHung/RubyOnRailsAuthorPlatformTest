class PostsController < ApplicationController
  before_action :set_post, only: %i(show edit update destroy)
  before_action :set_comment, only: %i(show)
  before_action :authenticate_author!

  def index
    @posts = Post.page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(
      post_params
    )

    @post.save!
    redirect_to posts_path
  end

  def update
    @post.update!(post_params)

    redirect_to post_path(@post)
  end

  def destroy
    @post.comments.destroy_all
    @post.destroy

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(
      :title, :body, :author_id
    )
  end

  def set_post
    @post = Post.includes(
      comments: :author
    ).find(params[:id])
  end

  def set_comment
    @comment = Comment.new
  end
end
