require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  let(:user) { FactoryBot.create(:user, :admin_user)}

  scenario 'user sign in, create, sign out, my page button is show' do
    visit_root_closed_modal

    expect(page).to have_selector '.sign_in_button'

    sign_in user
    visit root_path

    expect(page).to have_selector '.sign_out_button'
    expect(page).to have_selector '.my_page_link'
  end

  # scenario 'user signed out flash message' do
  #   user = users(:watanabe)
  #   sign_in user
  #   visit_root_closed_modal

  #   click_link('ログアウト')
  #   expect(page).to have_selector '#flash', text: 'ログアウトしました。'
  # end

  # scenario 'showing user mypage' do
  #   user = users(:watanabe)
  #   sign_in user
  #   visit user_path(user)
  #   user_created_spots = Spot.where(user_id: user.id)
  #   expect(page).to have_selector  'p', text: user.name
  #   assert_text "アカウント作成日 : #{user.created_at.year}年#{user.created_at.month}月#{user.created_at.day}日"
  #   assert_text "登録した事故スポットの数 : #{user_created_spots.length}"
  # end

  # scenario 'upload user_icon image file' do
  #   user = users(:watanabe)
  #   sign_in user
  #   visit edit_user_registration_path(user)
  #   attach_file 'user_avatar', Rails.root.join('test/fixtures/files/user_icon.webp').to_s
  #   click_on('更新する')

  #   expect(page).to have_selector  "img[src*='user_icon.webp']"
  #   click_on('プロフィール編集')
  #   page.accept_confirm do
  #     find('#avatar_del_link', text: '画像を削除').click
  #   end
  #   expect(page).to have_selector  '#flash', text: '削除しました'
  #   assert_no_selector "img[src*='user_icon.webp']"
  #   expect(page).to have_selector  '.user_default_icon', text: 'Y'
  # end

  # scenario 'edit user' do
  #   user = users(:watanabe)
  #   sign_in user
  #   visit edit_user_registration_path(user)

  #   fill_in('user[name]', with: 'test')
  #   click_on('更新する')
  #   expect(page).to have_selector  '#flash', text: 'アカウント情報を変更しました。'
  #   expect(page).to have_selector  'p', text: 'test'
  # end

  # scenario 'delete user' do
  #   user = users(:watanabe)
  #   sign_in user
  #   visit edit_user_registration_path(user)
  #   accept_confirm do
  #     find('button.delete_account_button', text: 'アカウントを削除する').click
  #   end
  #   expect(page).to have_selector  '#flash', text: 'ユーザーを削除しました'
  # end

  # scenario 'check user page title' do
  #   visit root_path
  #   assert_equal 'メインページ | MAAKS', page.title
  #   visit new_user_session_path
  #   assert_equal 'ログイン | MAAKS', page.title

  #   user = users(:watanabe)
  #   sign_in user

  #   visit user_path(user)
  #   assert_equal "#{user.name} | MAAKS", page.title
  #   visit edit_user_registration_path(user)
  #   assert_equal 'ユーザー編集 | MAAKS', page.title
  # end
end