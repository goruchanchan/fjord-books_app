# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    user = User.new(email: 'hoge@example.com', name: '')
    assert_equal 'hoge@example.com', user.name_or_email

    user.name = 'hoge'
    assert_equal 'hoge', user.name_or_email
  end

  test '#follow' do
    he = User.create!(email: 'he@example.com', password: 'password')
    her = User.create!(email: 'her@example.com', password: 'password')

    assert_not he.following?(her)
    he.follow(her)
    assert he.following?(her)
  end
end
