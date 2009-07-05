class CommentsController < ApplicationController
  def new
  end

  def create
    @comment = Comment.new(params[:comment])
    commentable_id = params["#{params[:model_name].downcase}_id"]
    commentable = params[:model_name].classify.constantize.find commentable_id
    @comment.user_id = current_user
    if commentable  && current_user
      @comment.commentable  = commentable
    else
      raise ActiveRecord::RecordNotFound
    end
    unless @comment.save
      flash[:error] = "Не могу сохранить комментарий"
    end
    redirect_to :back
  end


end
