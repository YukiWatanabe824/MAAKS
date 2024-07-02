# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  let(:user) { FactoryBot.create(:user, :admin_user) }
  let(:user_spot) { FactoryBot.create(:spot, :make_by_admin_user) }

  context 'when acessess to top page' do
    let(:user) { FactoryBot.create(:user, :admin_user) }
    let(:user_spot) { FactoryBot.create(:spot, :make_by_admin_user) }

    it 'desplayed sign in button' do
      visit_root_closed_modal

      expect(page).to have_selector '.sign_in_button'
    end

    context 'when user logged in' do
      before do
        sign_in user
      end

      let(:setup_icon_upload) do
        visit edit_user_registration_path(user)
        attach_file 'user_avatar', Rails.root.join('spec/files/user_icon.webp').to_s
        click_on('更新する')
      end

      let(:delete_icon) do
        setup_icon_upload
        click_on('プロフィール編集')
        page.accept_confirm do
          find('#avatar_del_link', text: '画像を削除').click
        end
      end

      it 'user page title is displayed user name' do
        visit user_path(user)
        expect(page.title).to eq "#{user.name} | MAAKS"
      end

      it 'user edit page title is ユーザー編集' do
        visit edit_user_registration_path(user)
        expect(page.title).to eq 'ユーザー編集 | MAAKS'
      end

      it 'displayed sign out button' do
        visit root_path
        expect(page).to have_selector '.sign_out_button'
      end

      it 'displayed my page button' do
        visit root_path
        expect(page).to have_selector '.my_page_link'
      end

      it 'displayed flash message when user logged out' do
        visit_root_closed_modal

        click_link('ログアウト')
        expect(page).to have_selector '#flash', text: 'ログアウトしました。'
      end

      it 'showing user name in user page' do
        visit user_path(user)
        expect(page).to have_selector 'p', text: user.name
      end

      it 'showing create at in user page' do
        visit user_path(user)
        expect(page).to have_text "アカウント作成日 : #{user.created_at.year}年#{user.created_at.month}月#{user.created_at.day}日"
      end

      it 'upload user_icon image file' do
        visit edit_user_registration_path(user)
        attach_file 'user_avatar', Rails.root.join('spec/files/user_icon.webp').to_s
        click_on('更新する')
        expect(page).to have_selector "img[src*='user_icon.webp']"
      end

      it 'displayed message when delete user_icon' do
        delete_icon
        expect(page).to have_selector '#flash', text: '削除しました'
      end

      it 'delete user_icon' do
        delete_icon
        expect(page).to have_no_selector "img[src*='user_icon.webp']"
      end

      it 'displayed default_icon after delete user_icon' do
        delete_icon
        expect(page).to have_selector '.user_default_icon', text: 'Y'
      end
    end

    context 'when user edit and delete' do
      before do
        sign_in user
      end

      let(:edit_user) do
        visit edit_user_registration_path(user)
        fill_in('user[name]', with: 'test')
        click_on('更新する')
      end

      it 'display message after edit user' do
        edit_user
        expect(page).to have_selector '#flash', text: 'アカウント情報を変更しました。'
      end

      it 'display edited contents after edit user' do
        edit_user
        expect(page).to have_selector 'p', text: 'test'
      end

      it 'delete user' do
        visit edit_user_registration_path(user)
        accept_confirm do
          find('button.delete_account_button', text: 'アカウントを削除する').click
        end
        expect(page).to have_selector '#flash', text: 'ユーザーを削除しました'
      end
    end
  end
end
