require 'application_system_test_case'

class SpotsTest < ApplicationSystemTestCase
  test 'showing spots on map' do
    visit '/'
    find('.close_modal_button').click
    assert_equal spots.length, page.all('.spot_marker', visible: false).count
  end

  test 'showing spot menu by right click on spot marker' do
    visit '/'
    find('.close_modal_button').click
    find('#map').click
    find('#map').click
    find('#new_spot_marker').right_click
    assert_selector('#spot_menu')
  end

  test 'showing spot info in side menu' do
    visit '/'
    find('.close_modal_button').click
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
end
