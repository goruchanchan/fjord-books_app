# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit following followers]

  def index
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show; end

  def edit; end

  def following
    @title = User.human_attribute_name(:follow)
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = User.human_attribute_name(:follower)
    @users = @user.followers
    render 'show_follow'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
end
