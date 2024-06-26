# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminUserTests', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  let(:make_by_admin_spot) { FactoryBot.create(:spot, :make_by_admin_user) }
  let(:make_by_standard_spot) { FactoryBot.create(:spot, :make_by_standard_user) }
  let(:admin_user) { FactoryBot.create(:user, :admin_user) }
  let(:not_admin_user) { FactoryBot.create(:user, :not_admin_user) }

  scenario 'admin なら自分以外のユーザーも編集できる' do
    spot = make_by_standard_spot
    sign_in admin_user
    visit_root_closed_modal

    find(".spot-#{spot.id}", visible: false).click(x: 0, y: -5)
    click_on '編集'
    choose('spot_accident_type_物損事故')
    click_button '更新する'

    expect(page).to have_selector '#flash', text: '更新しました'
    expect(page).to have_text '物損事故'
  end

  scenario 'adminなら他のユーザーのスポットを削除できる' do
    spot = make_by_standard_spot
    sign_in admin_user
    visit_root_closed_modal

    find(".spot-#{spot.id}", visible: false).click(x: 0, y: -5)
    accept_confirm do
      click_on '削除'
    end

    expect(page).to have_selector '#flash', text: '削除しました'
  end

  scenario 'adminなら他のユーザーを編集できる' do
    make_by_standard_spot
    user = not_admin_user
    sign_in admin_user
    visit user_path(admin_user)

    expect(page).to have_text 'ユーザー一覧'
    click_on('ユーザー一覧')

    expect(page).to have_text user.name
    expect(page).to have_text user.id

    find("#edit-#{user.id}", text: '編集').click
    click_on '更新する'
    expect(page).to have_selector '#flash', text: '更新しました'
  end

  scenario 'adminなら他のユーザーのアイコンを編集できる' do
    user = not_admin_user
    sign_in admin_user

    visit edit_admins_user_path(user)
    attach_file 'user_avatar', Rails.root.join('test/fixtures/files/user_icon.webp').to_s
    click_on '更新する'

    expect(page).to have_selector "img[src*='user_icon.webp']"
    visit edit_admins_user_path(user)
    page.accept_confirm do
      find('#avatar_del_link', text: '画像を削除').click
    end
    expect(page).to have_selector '#flash', text: '削除しました'
    expect(page).to have_no_selector "img[src*='user_icon.webp']"
    expect(page).to have_selector '.user_default_icon'
  end

  scenario 'adminなら他のユーザーを削除できる' do
    user = not_admin_user
    sign_in admin_user
    visit admins_users_path
    accept_confirm do
      find("#del-#{user.id}", text: '削除').click
    end
    expect(page).to have_selector '#flash', text: 'ユーザーを削除しました'
  end

  scenario 'adminじゃないユーザーがadmin権限が必要なページにアクセスするとnot foundを返す' do
    sign_in not_admin_user
    visit admins_users_path
    expect(page).to have_text 'Not Found'
  end
end
