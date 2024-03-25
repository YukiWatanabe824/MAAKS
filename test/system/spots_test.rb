# frozen_string_literal: true

require 'application_system_test_case'

class SpotsTest < ApplicationSystemTestCase
  test 'showing spots on map' do
    visit_root_closed_modal
    assert_equal spots.length, page.all('.spot_marker', visible: false).count
  end

  test 'showing spot menu by right click on spot marker' do
    visit_root_closed_modal
    spot = spots(:one)

    find(".spot-#{spot.id}", visible: false).click(x: 50, y: 50)
    find('#new_spot_marker').right_click
    assert_selector '#spot_menu'
  end

  test 'showing spot info in side menu by not signed in' do
    visit_root_closed_modal
    assert_selector '#map'
    assert_selector '.mapboxgl-canvas-container'

    spot = spots(:one)

    find(".spot-#{spot.id}", visible: false).click(x: 0, y: -5)
    assert_selector '.spot_accident_date', text: "#{spot.accident_date.year}年#{spot.accident_date.month}月#{spot.accident_date.day}日"
    assert_selector '.spot_accident_type', text: spot.accident_type
    assert_selector '.spot_created_at', text: "#{spot.created_at.year}年#{spot.created_at.month}月#{spot.created_at.day}日"
    assert_selector '.spot_id', text: spot.id
  end

  test 'create spot' do
    user = users(:watanabe)
    sign_in user
    visit_root_closed_modal

    spot = spots(:one)

    find(".spot-#{spot.id}", visible: false).click(x: 50, y: 50)
    find('#new_spot_marker').right_click
    click_on('スポットを作成する')

    choose('spot_accident_type_物損事故')
    fill_in('追加情報', with: 'test')
    fill_in '事故の発生日', with: Date.new(2021, 1, 1)
    click_on('登録する')
    assert_selector '.spot_accident_type', text: '物損事故'
    assert_selector '.spot_content', text: 'test'
  end

  test 'unknown accident date' do
    user = users(:watanabe)
    sign_in user
    visit_root_closed_modal

    spot = spots(:one)

    find(".spot-#{spot.id}", visible: false).click(x: 50, y: 50)
    find('#new_spot_marker').right_click
    click_on('スポットを作成する')

    choose('spot_accident_type_物損事故')
    fill_in '追加情報', with: 'test'
    fill_in '事故の発生日', with: Date.new(2021, 1, 1)
    check '正確な日付がわからない'
    click_on('登録する')
    assert_selector '.spot_accident_date', text: '発生日 : 2021年1月1日 ごろ'
  end

  test 'create a spot but a warning appears if you are not logged in' do
    visit_root_closed_modal
    assert_selector '#map'

    spot = spots(:one)

    find(".spot-#{spot.id}", visible: false).click(x: 50, y: 50)

    assert_selector '#new_spot_marker'
    find('#new_spot_marker').right_click
    click_on('スポットを作成する')

    assert_text 'スポットの登録にはユーザー登録が必要です'
    find('.spot-creating-required-logged-in').click
    assert_text 'ログイン'
  end

  test 'error message is displayedcreate when create spot' do
    user = users(:watanabe)
    sign_in user
    visit_root_closed_modal
    assert_selector '#map'

    spot = spots(:one)

    find(".spot-#{spot.id}", visible: false).click(x: 50, y: 50)

    assert_selector '#new_spot_marker'
    find('#new_spot_marker').right_click
    click_on('スポットを作成する')

    click_on('登録する')
    assert_text '入力内容に不備があり、登録できませんでした'
  end

  test 'edit spot' do
    user = users(:watanabe)
    sign_in user
    visit_root_closed_modal

    find(".spot-#{user.spots[0].id}", visible: false).click(x: 0, y: -5)
    click_on '編集'
    fill_in('タイトル', with: 'edited test')
    choose('spot_accident_type_物損事故')
    click_button '更新する'

    assert_selector '#flash', text: '更新しました'
  end

  test 'destroy spot' do
    user = users(:watanabe)
    sign_in user
    visit_root_closed_modal

    find(".spot-#{user.spots[0].id}", visible: false).click(x: 0, y: -5)
    accept_confirm do
      click_on '削除'
    end

    assert_selector '#flash', text: '削除しました'
  end
end
