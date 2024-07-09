# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  describe 'when visiting top page' do
    context 'when top page access' do
      it 'get page title' do
        visit root_path
        expect(page).to have_title 'メインページ | MAAKS'
      end

      it 'modal displayed when first access' do
        visit root_path
        expect(page).to have_selector '#how_to_maaks_modal', visible: :visible
      end

      it 'modal of howto displayed' do
        visit_root_closed_modal
        find_button('使い方').click
        expect(page).to have_content '安全にサイクリングをして、無事に帰ってくる。'
        find('.close_modal_button').click
      end

      it 'modal of terms displayed' do
        visit_root_closed_modal
        find('.terms_of_service').click
        expect(page).to have_content 'この利用規約（以下，「本規約」といいます。）は、'
      end

      it 'modal of policy displayed' do
        visit_root_closed_modal
        find('.privacy_policy').click
        expect(page).to have_content '本ウェブサイト上で提供するサービス（以下,「本サービス」といいます。）は，'
      end

      it 'showing map' do
        visit root_path
        expect(page).to have_selector '.mapboxgl-map'
      end

      it 'latest spot list tab is displayed' do
        visit root_path
        expect(page).to have_selector 'a.tab.active-tab', text: '最新の投稿'
      end
    end

    context 'when top page two accessings' do
      it 'modal not displayed when second access' do
        visit root_path
        visit root_path
        expect(page).to have_no_selector '#how_to_maaks_modal', visible: :visible
      end
    end

    context 'when user logged in' do
      it 'dislayed my spots list in side menu' do
        user = FactoryBot.create(:user, :admin_user)
        sign_in user
        visit_root_closed_modal
        find('a.tab.text-primary').click
        expect(page).to have_selector 'a.tab.active-tab', text: '自分の投稿'
      end
    end

    it 'showing developpers X' do
      visit_root_closed_modal
      expect(page).to have_selector '.developers_sns_x', wait: 15
      expect(page).to have_selector '.x_logo_mark', wait: 15
    end

    it 'showing developpers GitHub' do
      visit root_path
      aggregate_failures do
        expect(page).to have_selector '.developers_github', wait: 15
        expect(page).to have_selector '.github_logo_mark', wait: 15
      end
    end
  end
end
