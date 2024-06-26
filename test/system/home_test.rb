# frozen_string_literal: true

require 'application_system_test_case'

class HomeTest < ApplicationSystemTestCase
  test 'visiting the top page' do
    visit root_path
    assert_equal 'メインページ | MAAKS', title
  end

  test 'showing how to modal when first access in day and no show how to modal when after the second access that day' do
    visit root_path
    assert_selector '#how_to_maaks_modal', visible: :visible
    visit root_path
    assert_no_selector '#how_to_maaks_modal', visible: :visible
  end

  test 'open and close three modal' do
    visit_root_closed_modal
    find_button('使い方').click
    assert_text '安全にサイクリングをして、無事に帰ってくる。'
    find('.close_modal_button').click
    find('.terms_of_service').click
    assert_text 'この利用規約（以下，「本規約」といいます。）は、'
    find('.close_modal_button').click
    find('.privacy_policy').click
    assert_text '本ウェブサイト上で提供するサービス（以下,「本サービス」といいます。）は，'
  end

  test 'latest spot list tab is displayed' do
    visit_root_closed_modal
    assert_selector 'a.tab.active-tab', text: '最新の投稿'

    user = users(:watanabe)
    sign_in user
    visit root_path

    find('a.tab.text-primary').click
    assert_no_selector 'a.tab.active-tab', text: '最新の投稿'
    assert_selector 'a.tab.active-tab', text: '自分の投稿'
  end

  test 'showing map' do
    visit_root_closed_modal
    assert_selector '.mapboxgl-map'
  end

  test 'showing developpers sns' do
    visit_root_closed_modal
    assert_selector '.developers_sns_x'
    assert_selector '.x_logo_mark'
    assert_selector '.developers_github'
    assert_selector '.github_logo_mark'
  end
end
