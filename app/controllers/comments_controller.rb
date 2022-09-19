# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :create_comment, only: %i[create]
  before_action :set_redirect_path, only: %i[create destroy update]
  before_action :set_comment, only: %i[destroy edit update]
  before_action :set_commentable, only: %i[edit]

  def edit; end

  # POST /comments
  # POST /comments.json
  def create
    respond_to do |format|
      if @comment.save
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

  def create_comment
    @comment = if request.path.match?(%r{/reports/})
                 Report.find(params[:report_id]).comments.new(content: params[:content], user_id: current_user.id)
               else
                 Book.find(params[:book_id]).comments.new(content: params[:content], user_id: current_user.id)
               end
  end

  def set_commentable
    @commentable = if request.path.match?(%r{/reports/})
                     Report.find(params[:report_id])
                   else
                     Book.find(params[:book_id])
                   end
  end

  def set_redirect_path
    @redirect_path = if request.path.match?(%r{/reports/})
                       report_path(id: params[:report_id])
                     else
                       book_path(id: params[:book_id])
                     end
  end
end
