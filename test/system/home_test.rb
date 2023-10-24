require 'application_system_test_case'

class HomeTest < ApplicationSystemTestCase
  test 'visiting the top page' do
    visit '/'
    assert_equal 'MAAKS サイクリングの危ないスポットを「マークす」る', title
  end

  test 'showing how to modal when first access in day and no show how to modal when after the second access that day' do
    visit '/'
    assert_selector('#how_to_maaks_modal', visible: :visible)
    visit '/'
    assert_no_selector('#how_to_maaks_modal', visible: :visible)
  end

  test 'open and close three modal' do
    visit_root_closed_modal
    find_button('このサービスの使い方').click
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
    assert_selector 'a.tab.tab-active', text: '最新の投稿'

    user = users(:watanabe)
    sign_in user
    visit '/'

    find('a.tab.opacity-50').click
    assert_no_selector 'a.tab.tab-active', text: '最新の投稿'
    assert_selector 'a.tab.tab-active', text: '自分の投稿'
  end

  test 'showing map' do
    visit_root_closed_modal
    assert_selector('.mapboxgl-map')
  end

  test 'showing developpers sns' do
    visit_root_closed_modal
    assert_selector('.developers_sns_x')
    assert_selector('.x_logo_mark')
    assert_selector('.developers_github')
    assert_selector('.github_logo_mark')
  end
end
