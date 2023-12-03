# frozen_string_literal: true

require 'application_system_test_case'

class AdminUserTest < ApplicationSystemTestCase
  test 'edit spot by admin' do
    admin_user = users(:watanabe)
    user = users(:otameshisan)
    sign_in admin_user
    visit_root_closed_modal

    find(".spot-#{user.spots[0].id}", visible: false).click(x: 0, y: -5)
    click_on '編集'
    fill_in('タイトル', with: 'edited test')
    select('物損事故', from: 'spot_accident_type')
    click_button '更新する'

    assert_selector '#flash', text: '更新しました'
    assert_selector '.spot_title', text: 'edited test'
  end

  test 'destroy spot by admin' do
    admin_user = users(:watanabe)
    user = users(:otameshisan)
    sign_in admin_user
    visit_root_closed_modal

    find(".spot-#{user.spots[0].id}", visible: false).click(x: 0, y: -5)
    accept_confirm do
      click_on '削除'
    end

    assert_selector '#flash', text: '削除しました'
  end

  test 'edit user by admin' do
    admin_user = users(:watanabe)
    user = users(:otameshisan)
    sign_in admin_user
    visit "users/#{admin_user.id}/"

    assert_text 'ユーザー一覧'
    click_on('ユーザー一覧')

    assert_text user.name
    assert_text user.id

    click_on user.name
    click_on 'プロフィール編集'
    click_on '更新する'
    assert_selector('#flash', text: 'アカウント情報を変更しました。')
  end

  test 'destroy user by admin' do
    admin_user = users(:watanabe)
    user = users(:otameshisan)
    sign_in admin_user
    visit 'admin/users'
    click_on user.name.to_s
    click_on 'プロフィール編集'
    accept_confirm do
      find('button.delete_account_button', text: 'アカウントを削除する').click
    end
    assert_selector('#flash', text: 'ユーザーを削除しました')
  end

  test 'Routing error screen when accessing the users page without admin' do
    user = users(:otameshisan)
    sign_in user
    visit 'admin/users'
    assert_text 'Not Found'
  end
end
