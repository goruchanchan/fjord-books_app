# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  setup do
    @user = users(:hoge)
    @he = users(:he)
    @her = users(:her)
  end

  test '#name_or_email' do
    assert_equal 'hoge@example.com', @user.name_or_email
    @user.name = 'hoge'
    assert_equal 'hoge', @user.name_or_email
  end

  test '#follow' do
    assert_not @he.following?(@her)
    @he.follow(@her)
    assert @he.following?(@her)
  end

  test '#unfollow' do
    @her.follow(@user)
    assert @user.followed_by?(@her)
    @her.unfollow(@user)
    assert_not @user.followed_by?(@her)
  end
end
