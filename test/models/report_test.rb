# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  fixtures :reports
  fixtures :users

  setup do
    @report = reports(:one)
  end

  test '#editable' do
    assert @report.editable?(users(:hoge))
    assert_not @report.editable?(users(:he))
  end
end
