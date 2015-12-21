class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :set_category, only: [:new, :edit]
  before_action :require_user, except: [:show, :index ]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "You create a post"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Update a post"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private 

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_category
    @categories = Category.all
  end
end
