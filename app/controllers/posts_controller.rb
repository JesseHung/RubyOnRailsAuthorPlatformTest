class PostsController < ApplicationController
  before_action :set_placement, only: %i(show edit update)
  before_action :authenticate_author!

  def index
    @posts = Post.all
  end

  def set_placement
    @post = Post.find(params[:id])
  end
end
