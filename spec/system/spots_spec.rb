require 'rails_helper'

RSpec.describe "Spots", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  let(:make_by_admin_spot) { FactoryBot.create(:spot, :make_by_admin_user) }
  let(:make_by_standard_spot) { FactoryBot.create(:spot, :make_by_standard_user) }
  let(:user) { FactoryBot.create(:user, :admin_user) }
  let(:not_admin_user) { FactoryBot.create(:user, :not_admin_user) }

  scenario 'spot should appear on the map' do
    make_by_admin_spot
    visit_root_closed_modal
    expect(Spot.all.length).to eq page.all('.spot_marker', visible: false).count
  end

  scenario 'Right-clicking on a spot marker should bring up the spot menu' do
    visit_root_closed_modal

    find(".mapboxgl-map").click(x: 50, y: 50)
    find('#new_spot_marker').right_click
    expect(page).to have_selector '#spot_menu'
  end

  scenario 'Spot information is displayed in the side menu when not logged in' do
    spot = make_by_admin_spot
    visit_root_closed_modal
    expect(page).to have_selector '#map'
    expect(page).to have_selector '.mapboxgl-canvas-container'

    find(".spot-#{spot.id}", visible: false).click(x: 0, y: -5)
    expect(page).to have_selector '.spot_accident_date', text: "#{spot.accident_date.year}年#{spot.accident_date.month}月#{spot.accident_date.day}日"
    expect(page).to have_selector '.spot_accident_type', text: spot.accident_type
    expect(page).to have_selector '.spot_created_at', text: "#{spot.created_at.year}年#{spot.created_at.month}月#{spot.created_at.day}日"
    expect(page).to have_selector '.spot_id', text: spot.id
  end

  scenario 'A spot can be registered when the user is logged in' do
    spot = make_by_admin_spot
    sign_in user
    visit_root_closed_modal

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

  scenario 'Users can register a spot even if the date of the accident is not known' do
    spot = make_by_admin_spot
    sign_in user
    visit_root_closed_modal

    find(".spot-#{spot.id}", visible: false).click(x: 50, y: 50)
    find('#new_spot_marker').right_click
    click_on('スポットを作成する')

    choose('spot_accident_type_物損事故')
    fill_in '追加情報', with: 'test'
    fill_in '事故の発生日', with: Date.new(2021, 1, 1)
    check '正確な日付がわからない'
    click_on('登録する')
    expect(page).to have_selector '.spot_accident_date', text: '発生日 : 2021年1月1日 ごろ'
  end

  scenario 'Alerts are displayed when registering a spot if the user is not logged in' do
    spot = make_by_admin_spot
    visit_root_closed_modal
    expect(page).to have_selector '#map'


    find(".spot-#{spot.id}", visible: false).click(x: 50, y: 50)

    expect(page).to have_selector '#new_spot_marker'
    find('#new_spot_marker').right_click
    click_on('スポットを作成する')

    expect(page).to have_text 'スポットの登録にはユーザー登録が必要です'
    find('.spot-creating-required-logged-in').click
    expect(page).to have_text 'ログイン'
  end

  scenario 'Incomplete entries will alert you when registering a spot' do
    spot = make_by_admin_spot
    sign_in user
    visit_root_closed_modal
    expect(page).to have_selector '#map'


    find(".spot-#{spot.id}", visible: false).click(x: 50, y: 50)

    expect(page).to have_selector '#new_spot_marker'
    find('#new_spot_marker').right_click
    click_on('スポットを作成する')

    click_on('登録する')
    expect(page).to have_text '入力内容に不備があり、登録できませんでした'
  end

  scenario 'Spots created by users themselves can be edited' do
    spot = make_by_standard_spot
    user = spot.user
    sign_in user
    visit_root_closed_modal

    find(".spot-#{spot.id}", visible: false).click(x: 0, y: -5)
    click_on '編集'
    fill_in('タイトル', with: 'edited test')
    choose('spot_accident_type_物損事故')
    click_button '更新する'

    expect(page).to have_selector '#flash', text: '更新しました'
  end

  scenario 'Spots created by users themselves can be deleted' do
    spot = make_by_standard_spot
    sign_in spot.user
    visit_root_closed_modal

    find(".spot-#{spot.id}", visible: false).click(x: 0, y: -5)
    accept_confirm do
      click_on '削除'
    end

    expect(page).to have_selector '#flash', text: '削除しました'
  end
end
