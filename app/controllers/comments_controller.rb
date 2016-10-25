class CommentsController < ApplicationController
  before_action :find_comment, only: [:edit, :update]
  before_action :authenticate_user! # only user can create comment.
  def create
    # find the post.
    @post = Post.friendly.find(params[:post_id])
    # create a comment , we are permiting only the content field.
    @comment = Comment.create(params[:comment].permit(:content))
    # we will assign the user id on the comment
    @comment.user_id = current_user.id
    # we will also assign the post id on the comment
    @comment.post_id = @post.id

    # save the comment
    respond_to do |format|
      if @comment.save
        # format.html {redirect_to post_path( @post) }  # it will redirect to the show page.
        format.js
      else
        format.html{ render 'new' }
      end
    end

  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    # @comment.update_attributes(params[:comment])
    respond_to do |format|
      if @comment.update comment_params
        format.js
      else
        format.html{ render 'new' }
      end
    end
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
    @post = Post.friendly.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
