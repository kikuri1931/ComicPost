class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @picture = Picture.find(params[:picture_id])
    @comment = current_user.comments.new(comment_params)
    @comment.picture_id = @picture.id
    @comment.score = Language.get_data(comment_params[:comment])
    unless @comment.save
      render 'error'
    end
  end

  def destroy
    @picture = Picture.find(params[:picture_id])
    Comment.find_by(id: params[:id], picture_id: params[:picture_id]).destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
