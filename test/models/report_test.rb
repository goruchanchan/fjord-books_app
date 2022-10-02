# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable' do
    user = User.new(email: 'user@example.com', name: 'user')
    user.reports.new(id:1, title: 'test')
    report = user.reports.first

    assert report.editable?(user)
    other = User.new(email: 'other@example.com', name: 'other')
    assert_not report.editable?(other)

  end
end
