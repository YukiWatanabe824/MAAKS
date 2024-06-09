# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  scenario 'visiting the top page' do
    visit root_path
    expect(page).to have_title 'メインページ | MAAKS'
  end

  scenario 'showing how to modal when first access in day and no show how to modal when after the second access that day' do
    visit root_path
    expect(page).to have_selector '#how_to_maaks_modal', visible: :visible
    visit root_path
    expect(page).to have_no_selector '#how_to_maaks_modal', visible: :visible
  end

  scenario 'open and close three modal' do
    visit_root_closed_modal
    find_button('使い方').click
    expect(page).to have_content '安全にサイクリングをして、無事に帰ってくる。'
    find('.close_modal_button').click
    find('.terms_of_service').click
    expect(page).to have_content 'この利用規約（以下，「本規約」といいます。）は、'
    find('.close_modal_button').click
    find('.privacy_policy').click
    expect(page).to have_content '本ウェブサイト上で提供するサービス（以下,「本サービス」といいます。）は，'
  end

  scenario 'latest spot list tab is displayed' do
    visit_root_closed_modal
    expect(page).to have_selector 'a.tab.active-tab', text: '最新の投稿'

    user = FactoryBot.create(:user, :admin_user)
    sign_in user
    visit root_path

    find('a.tab.text-primary').click
    expect(page).to   have_no_selector 'a.tab.active-tab', text: '最新の投稿'
    expect(page).to   have_selector 'a.tab.active-tab', text: '自分の投稿'
  end

  scenario 'showing map' do
    visit_root_closed_modal
    expect(page).to have_selector '.mapboxgl-map'
  end

  scenario 'showing developpers sns' do
    visit_root_closed_modal
    expect(page).to have_selector '.developers_sns_x'
    expect(page).to have_selector '.x_logo_mark'
    expect(page).to have_selector '.developers_github'
    expect(page).to have_selector '.github_logo_mark'
  end
end
