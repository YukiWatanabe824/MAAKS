# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminUserTests', type: :system do
  describe 'when user is admin' do
    context 'when spot is other users spot' do
      let(:make_by_standard_spot) { FactoryBot.create(:spot, :make_by_standard_user) }
      let(:admin_user) { FactoryBot.create(:user, :admin_user) }

      let(:setup_spot_and_admin_user) do
        make_by_standard_spot
        sign_in admin_user
        visit_root_closed_modal
      end

      let(:edit_other_user_spot) do
        click_on '編集'
        choose('spot_accident_type_物損事故')
        click_button '更新する'
      end

      let(:delete_other_user_spot) do
        accept_confirm do
          click_on '削除'
        end
      end

      it 'user can edit' do
        setup_spot_and_admin_user
        find(".spot-#{make_by_standard_spot.id}", visible: false).click(x: 0, y: -5)
        edit_other_user_spot
        expect(page).to have_selector '#flash', text: '更新しました'
      end

      it 'editing content is saved' do
        setup_spot_and_admin_user
        find(".spot-#{make_by_standard_spot.id}", visible: false).click(x: 0, y: -5)
        edit_other_user_spot
        expect(page).to have_text '物損事故'
      end

      it 'user can delete' do
        setup_spot_and_admin_user
        find(".spot-#{make_by_standard_spot.id}", visible: false).click(x: 0, y: -5)
        delete_other_user_spot
        expect(page).to have_selector '#flash', text: '削除しました'
      end
    end

    context 'when go to user page' do
      let(:admin_user) { FactoryBot.create(:user, :admin_user) }
      let(:not_admin_user) { FactoryBot.create(:user, :not_admin_user) }
      let(:make_by_standard_spot) { FactoryBot.create(:spot, :make_by_standard_user) }

      let(:access_for_other_user_page) do
        make_by_standard_spot
        not_admin_user
        sign_in admin_user
        visit user_path(admin_user)
      end

      let(:edit_other_user_icon) do
        access_for_other_user_page
        visit edit_admins_user_path(not_admin_user)
        attach_file 'user_avatar', Rails.root.join('spec/fixtures/files/user_icon.webp').to_s
        click_on '更新する'
      end

      it 'get admins users page' do
        access_for_other_user_page
        expect(page).to have_text 'ユーザー一覧'
      end

      it 'get other user profile page' do
        access_for_other_user_page
        click_on('ユーザー一覧')
        expect(page).to have_text not_admin_user.id
      end

      it 'editing other user profile' do
        access_for_other_user_page
        click_on('ユーザー一覧')
        find("#edit-#{not_admin_user.id}", text: '編集').click
        click_on '更新する'
        expect(page).to have_selector '#flash', text: '更新しました'
      end

      it 'editing other users icon' do
        edit_other_user_icon
        expect(page).to have_selector "img[src*='user_icon.webp']"
      end

      it 'deleting message displayed when deleting other users icon' do
        edit_other_user_icon
        visit edit_admins_user_path(not_admin_user)
        page.accept_confirm { find('#avatar_del_link', text: '画像を削除').click }
        expect(page).to have_selector '#flash', text: '削除しました'
      end

      it 'default icon displayed when deleting other users icon' do
        edit_other_user_icon
        visit edit_admins_user_path(not_admin_user)
        page.accept_confirm { find('#avatar_del_link', text: '画像を削除').click }
        expect(page).to have_selector '.user_default_icon'
      end
    end

    context 'when go to other users page' do
      let(:admin_user) { FactoryBot.create(:user, :admin_user) }
      let(:not_admin_user) { FactoryBot.create(:user, :not_admin_user) }
      let(:make_by_standard_spot) { FactoryBot.create(:spot, :make_by_standard_user) }

      let(:setup_users) do
        not_admin_user
        sign_in admin_user
        visit admins_users_path
      end

      it 'other user account deleted clicking delete button' do
        setup_users
        accept_confirm do
          find("#del-#{not_admin_user.id}", text: '削除').click
        end
        expect(page).to have_selector '#flash', text: 'ユーザーを削除しました'
      end
    end
  end

  describe 'when user is not admin user' do
    context 'when accessing pages that require admin privileges' do
      let(:admin_user) { FactoryBot.create(:user, :admin_user) }
      let(:not_admin_user) { FactoryBot.create(:user, :not_admin_user) }

      it 'return not found' do
        sign_in not_admin_user
        visit admins_users_path
        expect(page).to have_text 'Not Found'
      end
    end
  end
end
