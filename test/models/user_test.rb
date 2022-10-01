# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  test '#name_or_email' do
    user = users(:hoge)
    assert_equal 'hoge@example.com', user.name_or_email

    user.name = 'hoge'
    assert_equal 'hoge', user.name_or_email
  end

  test '#follow' do
    he = users(:he)
    her = users(:her)

    assert_not he.following?(her)
    he.follow(her)
    assert he.following?(her)
  end

  test '#unfollow' do
    he = users(:he)
    her = users(:her)

    he.follow(her)
    assert he.following?(her)
    he.unfollow(her)
    assert_not he.following?(her)
  end
end
