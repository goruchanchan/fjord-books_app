# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:cherry_book)

    visit root_url
    fill_in 'Eメール', with: 'hoge@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: /^本$/
  end

  test 'creating a Book' do
    visit books_url
    click_on '新規作成'

    fill_in 'タイトル', with: 'チェリー本'
    fill_in 'メモ', with: 'わかりやすい'
    fill_in '著者', with: 'Junichi Ito'
    click_on '登録する'

    assert_text '本が作成されました。'
    assert_text 'チェリー本'
    assert_text 'わかりやすい'
    assert_text 'Junichi'
  end

  test 'updating a Book' do
    visit books_url
    click_on '編集'

    fill_in 'タイトル', with: @book.title
    fill_in 'メモ', with: @book.memo
    click_on '更新する'

    assert_text '本が更新されました。'
    assert_text 'とてもわかりやすい'
  end

  test 'destroying a Book' do
    visit books_url
    page.accept_confirm do
      click_on '削除'
    end

    assert_text '本が削除されました。'
  end
end
