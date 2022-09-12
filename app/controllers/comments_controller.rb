# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_parameter, only: %i[create destroy]
  before_action :set_comment, only: %i[destroy]

  # POST /comments
  # POST /comments.json
  def create
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @redirect_path, notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
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

  def set_parameter
    if request.path.match(/\/reports(\/)?/)
      @comment = Report.find(params[:report_id]).comments.new(content: params[:content], user_id: current_user.id)
      @redirect_path = report_path(id: params[:report_id])
    else
      @comment = Book.find(params[:book_id]).comments.new(content: params[:content], user_id: current_user.id)
      @redirect_path = book_path(id: params[:book_id])
    end
  end
end
