# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_redirect_path, only: %i[create destroy update]
  before_action :set_comment, only: %i[destroy edit update]
  before_action :set_commentable, only: %i[create edit]

  def edit; end

  # POST /comments
  # POST /comments.json
  def create
    comment = @commentable.comments.new(content: params[:content], user_id: current_user.id)

    respond_to do |format|
      if comment.save
        format.html { redirect_to @redirect_path, notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
      else
        format.html { redirect_to @redirect_path, notice: t('errors.messages.not_create', name: Comment.model_name.human) }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(content: params[:content])
        format.html { redirect_to @redirect_path, notice: t('controllers.common.notice_update', name: Comment.model_name.human) }
      else
        format.html { redirect_to @redirect_path, notice: t('errors.messages.not_update', name: Comment.model_name.human) }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to @redirect_path, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human) }
      else
        format.html { redirect_to @redirect_path, notice: t('errors.messages.not_destroy', name: Comment.model_name.human) }
      end
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_commentable
    @commentable = select_commentable_or_path(type: 'find')
  end

  def set_redirect_path
    @redirect_path = select_commentable_or_path(type: 'path')
  end

  def select_commentable_or_path(type:)
    if request.path.match?(%r{/reports/})
      type.eql?('find') ? Report.find(params[:report_id]) : report_path(id: params[:report_id])
    else
      type.eql?('find') ? Book.find(params[:book_id]) : book_path(id: params[:book_id])
    end
  end
end
