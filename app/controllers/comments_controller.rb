# frozen_string_literal: true

class CommentsController < ApplicationController
  # POST /comments
  # POST /comments.json
  def create
    if request.path.match(/\/reports(\/)?/)
      @comment = Report.find(params[:report_id]).comments.new(content: params[:content], user_id: current_user.id)
      redirect_path = report_path(id: params[:report_id])
    else
      @comment = Book.find(params[:book_id]).comments.new(content: params[:content], user_id: current_user.id)
      redirect_path = book_path(id: params[:book_id])
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to redirect_path, notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
end
