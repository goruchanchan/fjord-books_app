# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :set_user, only: %i[create destroy]

  def create
    current_user.follow(@user)
    redirect_to @user
  end

  def destroy
    current_user.unfollow(@user)
    redirect_to @user
  end

  def set_user
    @user = User.find(params[:id])
  end
end
