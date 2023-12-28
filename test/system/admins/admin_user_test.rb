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
    visit user_path(admin_user)

    assert_text 'ユーザー一覧'
    click_on('ユーザー一覧')

    assert_text user.name
    assert_text user.id

    find("#edit-#{user.id}", text: '編集').click
    click_on '更新する'
    assert_selector '#flash', text: '更新しました'
  end

  test 'edit user_icon by admin' do
    admin_user = users(:watanabe)
    user = users(:otameshisan)
    sign_in admin_user

    visit edit_admins_user_path(user)
    attach_file 'user_avatar', Rails.root.join('test/fixtures/files/user_icon.webp').to_s
    click_on '更新する'

    assert_selector "img[src*='user_icon.webp']"
    visit edit_admins_user_path(user)
    page.accept_confirm do
      find('#avatar_del_link', text: '画像を削除').click
    end
    assert_selector '#flash', text: '削除しました'
    assert_no_selector "img[src*='user_icon.webp']"
    assert_selector '.user_default_icon', text: 't'
  end

  test 'destroy user by admin' do
    admin_user = users(:watanabe)
    user = users(:otameshisan)
    sign_in admin_user
    visit admins_users_path
    accept_confirm do
      find("#del-#{user.id}", text: '削除').click
    end
    assert_selector '#flash', text: 'ユーザーを削除しました'
  end

  test 'routing error screen when accessing the users page without admin' do
    user = users(:otameshisan)
    sign_in user
    visit admins_users_path
    assert_text 'Not Found'

  end

  test 'error if not admin' do
    user = users(:otameshisan)

    sign_in user
    visit admins_users_path
    assert_text 'Not Found'
  end
end
