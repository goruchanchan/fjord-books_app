# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  fixtures :reports
  fixtures :users

  setup do
    @report = reports(:rails_test)
  end

  test '#editable' do
    assert @report.editable?(users(:hoge))
    assert_not @report.editable?(users(:he))
  end

  test '#created_on' do
    assert_equal Time.zone.now.to_date, @report.created_on
    assert_not_equal Time.zone.now.next_day.to_date, @report.created_on
  end
end
