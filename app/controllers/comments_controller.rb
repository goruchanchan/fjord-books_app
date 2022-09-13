# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_parameter, only: %i[create destroy]
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
        format.json { render :show, status: :created, location: @comment }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(content: params[:content])
        format.html { redirect_to @redirect_path, notice: t('controllers.common.notice_update', name: Comment.model_name.human) }
        format.json { render :show, status: :ok, location: @comment }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @redirect_path, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human) }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_commentable
    if request.path.match(/\/reports(\/)?/)
      @commentable = Report.find(params[:report_id])
    else
      @commentable = Book.find(params[:book_id])
    end
  end

  def set_parameter
    if request.path.match(/\/reports(\/)?/)
      @comment = Report.find(params[:report_id]).comments.new(content: params[:content], user_id: current_user.id)
      @redirect_path = report_path(id: params[:report_id])
    else
      @comment = Book.find(params[:book_id]).comments.new(content: params[:content], user_id: current_user.id)
      @redirect_path = book_path(id: params[:book_id])
    end
  end

  def set_redirect_path
    if request.path.match(/\/reports(\/)?/)
      @redirect_path = report_path(id: params[:report_id])
    else
      @redirect_path = book_path(id: params[:book_id])
    end
  end
end
