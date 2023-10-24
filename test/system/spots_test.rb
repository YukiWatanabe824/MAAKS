# frozen_string_literal: true

require 'application_system_test_case'

class SpotsTest < ApplicationSystemTestCase
  test 'showing spots on map' do
    visit_root_closed_modal
    assert_equal spots.length, page.all('.spot_marker', visible: false).count
  end

  test 'showing spot menu by right click on spot marker' do
    visit_root_closed_modal
    find('#map').click
    find('#new_spot_marker').right_click
    assert_selector('#spot_menu')
  end

  test 'showing spot info in side menu by not signed in' do
    visit_root_closed_modal
    assert_selector('#map')
    assert_selector('.mapboxgl-canvas-container')

    spot = spots(:one)

    find(".spot-#{spot.id}", visible: false).click(x: 0, y: -5)
    assert_selector '.spot_title', text: spot.title
    assert_selector '.spot_accident_date', text: "#{spot.accident_date.year}年#{spot.accident_date.month}月#{spot.accident_date.day}日"
    assert_selector '.spot_accident_type', text: spot.accident_type
    assert_selector '.spot_created_at', text: "#{spot.created_at.year}年#{spot.created_at.month}月#{spot.created_at.day}日"
    assert_selector '.spot_id', text: spot.id
  end

  test 'create spot' do
    user = users(:watanabe)
    sign_in user
    visit_root_closed_modal

    find('#map').click
    find('#new_spot_marker').right_click
    click_on('スポットを作成する')

    fill_in('タイトル', with: 'test')
    select('物損事故', from: '種別')
    fill_in('詳細', with: 'test')
    fill_in '発生日', with: Date.new(2021, 1, 1)
    click_on('登録する')
    assert_selector '.spot_title', text: 'test'
    assert_selector '.spot_accident_type', text: '物損事故'
    assert_selector '.spot_content', text: 'test'
  end

  test 'create a spot but a warning appears if you are not logged in' do
    visit_root_closed_modal
    assert_selector('#map')

    find('#map').click
    find('#new_spot_marker').right_click
    click_on('スポットを作成する')

    assert_text 'スポットの登録にはユーザー登録が必要です'
  end

  test 'edit spot' do
    user = users(:watanabe)
    sign_in user
    visit_root_closed_modal

    find(".spot-#{user.spot[0].id}", visible: false).click(x: 0, y: -5)
    click_on '編集'
    fill_in('タイトル', with: 'edited test')
    select('物損事故', from: 'spot_accident_type')
    click_button '更新する'

    assert_selector '#flash', text: '更新しました'
    assert_selector '.spot_title', text: 'edited test'
  end

  test 'destroy spot' do
    user = users(:watanabe)
    sign_in user
    visit_root_closed_modal

    find(".spot-#{user.spot[0].id}", visible: false).click(x: 0, y: -5)
    accept_confirm do
      click_on '削除'
    end

    assert_selector '#flash', text: '削除しました'
  end
end
