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
end
