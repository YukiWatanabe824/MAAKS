require 'rails_helper'

RSpec.describe "Spots", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  let(:make_by_admin_spot) { FactoryBot.create(:spot, :make_by_admin_user) }
  let(:make_by_standard_spot) { FactoryBot.create(:spot, :make_by_standard_user) }
  let(:user) { FactoryBot.create(:user, :admin_user) }

  scenario 'showing spots on map' do
    visit_root_closed_modal
    expect(Spot.all.length).to eq page.all('.spot_marker', visible: false).count
  end

  scenario 'showing spot menu by right click on spot marker' do
    visit_root_closed_modal

    find(".mapboxgl-map").click(x: 50, y: 50)
    find('#new_spot_marker').right_click
    expect(page).to have_selector '#spot_menu'
  end

  scenario 'showing spot info in side menu by not signed in' do
    visit_root_closed_modal
    expect(page).to have_selector '#map'
    expect(page).to have_selector '.mapboxgl-canvas-container'

    spot = Spot.all.first
    find(".spot-#{spot.id}", visible: false).click(x: 0, y: -5)
    expect(page).to have_selector '.spot_accident_date', text: "#{spot.accident_date.year}年#{spot.accident_date.month}月#{spot.accident_date.day}日"
    expect(page).to have_selector '.spot_accident_type', text: spot.accident_type
    expect(page).to have_selector '.spot_created_at', text: "#{spot.created_at.year}年#{spot.created_at.month}月#{spot.created_at.day}日"
    expect(page).to have_selector '.spot_id', text: spot.id
  end

  scenario 'create spot' do
    sign_in user
    visit_root_closed_modal

    spot = Spot.all.first

    find(".spot-#{spot.id}", visible: false).click(x: 50, y: 50)
    find('#new_spot_marker').right_click
    click_on('スポットを作成する')

    choose('spot_accident_type_物損事故')
    fill_in('追加情報', with: 'test')
    fill_in '事故の発生日', with: Date.new(2021, 1, 1)
    click_on('登録する')
    expect(page).to have_selector '.spot_accident_type', text: '物損事故'
    expect(page).to have_selector '.spot_content', text: 'test'
  end

  # scenario 'unknown accident date' do
  #   user = users(:watanabe)
  #   sign_in user
  #   visit_root_closed_modal

  #   spot = spots(:one)

  #   find(".spot-#{spot.id}", visible: false).click(x: 50, y: 50)
  #   find('#new_spot_marker').right_click
  #   click_on('スポットを作成する')

  #   choose('spot_accident_type_物損事故')
  #   fill_in '追加情報', with: 'test'
  #   fill_in '事故の発生日', with: Date.new(2021, 1, 1)
  #   check '正確な日付がわからない'
  #   click_on('登録する')
  #   assert_selector '.spot_accident_date', text: '発生日 : 2021年1月1日 ごろ'
  # end

  # scenario 'create a spot but a warning appears if you are not logged in' do
  #   visit_root_closed_modal
  #   assert_selector '#map'

  #   spot = spots(:one)

  #   find(".spot-#{spot.id}", visible: false).click(x: 50, y: 50)

  #   assert_selector '#new_spot_marker'
  #   find('#new_spot_marker').right_click
  #   click_on('スポットを作成する')

  #   assert_text 'スポットの登録にはユーザー登録が必要です'
  #   find('.spot-creating-required-logged-in').click
  #   assert_text 'ログイン'
  # end

  # scenario 'error message is displayedcreate when create spot' do
  #   user = users(:watanabe)
  #   sign_in user
  #   visit_root_closed_modal
  #   assert_selector '#map'

  #   spot = spots(:one)

  #   find(".spot-#{spot.id}", visible: false).click(x: 50, y: 50)

  #   assert_selector '#new_spot_marker'
  #   find('#new_spot_marker').right_click
  #   click_on('スポットを作成する')

  #   click_on('登録する')
  #   assert_text '入力内容に不備があり、登録できませんでした'
  # end

  # scenario 'edit spot' do
  #   user = users(:watanabe)
  #   sign_in user
  #   visit_root_closed_modal

  #   find(".spot-#{user.spots[0].id}", visible: false).click(x: 0, y: -5)
  #   click_on '編集'
  #   fill_in('タイトル', with: 'edited test')
  #   choose('spot_accident_type_物損事故')
  #   click_button '更新する'

  #   assert_selector '#flash', text: '更新しました'
  # end

  # scenario 'destroy spot' do
  #   user = users(:watanabe)
  #   sign_in user
  #   visit_root_closed_modal

  #   find(".spot-#{user.spots[0].id}", visible: false).click(x: 0, y: -5)
  #   accept_confirm do
  #     click_on '削除'
  #   end

  #   assert_selector '#flash', text: '削除しました'
  # end
end
