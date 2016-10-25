class PostsController < ApplicationController

  before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  # if youre not authenticated, you will redirect to the sign up page.
  before_action :authenticate_user!, except: [:show]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def show
    # retrieve all the comments for this post.
    @user_id = User.find(@post.user_id)
    @comments = Comment.where(post_id: @post).order('created_at DESC')
    # display related posts except the current post.
    @posts = Post.all.limit(4).order('created_at DESC').where(user_id: @user_id).where.not(id: @post.id)

  end

  def new
    # this make sure that the post is coming from the current user
    @post = current_user.posts.build
  end

  def create
    @post =  current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end

  end

  def edit
    # redirect_to root_path, notice: 'Thou Shalt Nought duuu dat', unless: current_user.id == @post.user_id
  end

  def update
    if @post.update(post_params)
      redirect_to @post # the show page
    else
      render 'edit' # edit page
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def upvote
    @post.upvote_by current_user
    respond_to do |format|
      format.js
    end
  end

  def downvote
    @post.downvote_by current_user
    respond_to do |format|
      format.js
    end
  end


  private

  def find_post
    @post = Post.friendly.find(params[:id]) # this will retrieve a post based on the id
  end

  def post_params
    params.require(:post).permit(:title, :link, :description, :image, :slug)
  end

end
