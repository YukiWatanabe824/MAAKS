require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'user sign in, create, sign out, my page button is show' do
    visit '/'
    find('.close_modal_button').click

    assert_selector('.sign_in_button')
    assert_selector('.create_user_button')

    user = users(:watanabe)
    sign_in user
    visit '/'

    assert_selector('.sign_out_button')
    assert_selector('.my_page_button')
  end

  test 'user signed out flash message' do
    user = users(:watanabe)
    sign_in user
    visit '/'
    find('.close_modal_button').click

    click_link('ログアウト')
    assert_selector('#flash', text: 'ログアウトしました。')
  end

  test 'sign-in and sign-up and associated flash messages' do
    visit '/users/sign_up'
    fill_in('ユーザー名', with: 'test')
    fill_in('メールアドレス', with: 'test@example.com')
    fill_in('パスワード', with: '123456')
    fill_in('user[password_confirmation]', with: '123456')
    click_on('アカウント登録')
    assert_selector('#flash', text: 'アカウント登録が完了しました。')

    find('.close_modal_button').click
    click_on('ログアウト')
    assert_selector('#flash', text: 'ログアウトしました。')

    visit '/users/sign_in'
    fill_in('メールアドレス', with: 'test@example.com')
    fill_in('パスワード', with: '12345678')
    click_on('commit')
    assert_selector('#flash', text: 'メールアドレスまたはパスワードが違います。')

    visit '/users/sign_in'
    fill_in('メールアドレス', with: 'test@example.com')
    fill_in('パスワード', with: '123456')
    click_on('commit')
    assert_selector('#flash', text: 'ログインしました。')
  end

  test 'showing user mypage' do
    user = users(:watanabe)
    sign_in user
    visit "users/#{user.id}"
    user_created_spots = Spot.where(user_id: user.id)
    assert_selector 'p', text: user.name
    assert_text "アカウント作成日 : #{user.created_at.year}年#{user.created_at.month}月#{user.created_at.day}日"
    assert_text "登録したスポットの数 : #{user_created_spots.length}"
  end

  test 'upload user_icon image file' do
    visit '/users/sign_up'
    attach_file 'user_avatar', "#{Rails.root.join('test/fixtures/files/user_icon.webp')}"
    fill_in('ユーザー名', with: 'test')
    fill_in('メールアドレス', with: 'test@example.com')
    fill_in('パスワード', with: '123456')
    fill_in('user[password_confirmation]', with: '123456')
    click_on('アカウント登録')

    find('.close_modal_button').click
    click_on('マイページ')
    assert_selector "img[src*='user_icon.webp']"
    click_on('プロフィール編集')
    accept_confirm do
      click_button('画像を削除')
    end
    assert_selector('#flash', text: '削除しました')
    assert_no_selector "img[src*='user_icon.webp']"
    assert_selector '.user_default_icon', text: 't'
  end

  test 'edit user' do
    user = users(:watanabe)
    sign_in user
    visit "users/#{user.id}/edit"

    fill_in('user[name]', with: 'test')
    fill_in('user[email]', with: 'zzz@example.com')
    click_on('更新する')
    assert_selector('#flash', text: 'アカウント情報を変更しました。')
    assert_selector('p', text: 'test')
  end

  test 'delete user' do
    user = users(:watanabe)
    sign_in user
    visit "users/#{user.id}/edit"
    accept_confirm do
      find('button.delete_account_button', text: 'アカウントを削除する').click
    end
    assert_selector('#flash', text: 'ユーザーを削除しました')
  end
end
