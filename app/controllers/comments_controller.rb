# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[destroy edit update]
  before_action :set_commentable, only: %i[create edit]

  def edit; end

  # POST /comments
  # POST /comments.json
  def create
    comment = @commentable.comments.new(content: params[:content], user_id: current_user.id)

    respond_to do |format|
      if comment.save
        format.html { redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
      else
        format.html { redirect_to @commentable, notice: t('errors.messages.not_create', name: Comment.model_name.human) }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(content: params[:content])
        format.html { redirect_to request.referer, notice: t('controllers.common.notice_update', name: Comment.model_name.human) }
      else
        format.html { redirect_to request.referer, notice: t('errors.messages.not_update', name: Comment.model_name.human) }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to request.referer, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human) }
      else
        format.html { redirect_to request.referer, notice: t('errors.messages.not_destroy', name: Comment.model_name.human) }
      end
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_commentable
    @commentable = request.path.match?(%r{/reports/}) ? Report.find(params[:report_id]) : Book.find(params[:book_id])
  end
end
