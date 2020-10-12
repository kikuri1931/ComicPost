class CommentsController < ApplicationController
  def create
    picture = Picture.find(params[:picture_id])
    comment = current_user.comments.new(comment_params)
    comment.picture_id = picture.id
    comment.save
    redirect_back(fallback_location: picture_path(picture))
  end

  def destroy
    picture = Picture.find(params[:picture_id])
    Comment.find_by(id: params[:id], picture_id: params[:picture_id]).destroy
    redirect_back(fallback_location: picture_path(picture))
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
