require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    visit root_url
    fill_in 'Eメール', with: 'hoge@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
  end

  test 'visiting the Report index' do
    visit reports_url
    assert_selector 'h1', text: '日報'
  end

  test 'creating a Report' do
    visit reports_url
    click_on '新規作成'

    fill_in 'タイトル', with: 'Railsでテストを書く'
    fill_in '内容', with: 'createをやってみた'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text 'Railsでテストを書く'
    assert_text 'createをやってみた'
    click_on '戻る'
  end

end
