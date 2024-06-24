require 'rails_helper'

RSpec.describe 'OmniauthGoogles', type: :system do
  before do
    driven_by(:selenium_chrome_headless)

    OmniAuth.config.test_mode = true
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth']  = google_oauth2_mock
  end

  after do
    OmniAuth.config.test_mode = false
  end

  let 'google_oauth2_mock' do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
                                                                         provider: 'google_oauth2',
                                                                         uid: '12345678910',
                                                                         info: {
                                                                           email: 'testing@gmail-fake.com',
                                                                           first_name: 'taro',
                                                                           last_name: 'test'
                                                                         },
                                                                         credentials: {
                                                                           token: 'abcdefgh12345',
                                                                           refresh_token: '12345abcdefgh',
                                                                           expires_at: DateTime.now
                                                                         }
                                                                       })
  end

  scenario 'authorizes and sets user currently in database with Google OAuth' do
    visit user_session_path
    expect(page).to have_text 'Googleでログイン'
    click_on 'Googleでログイン'
    expect(page).to have_selector '#flash', text: 'Google アカウントによる認証に成功しました。'
  end
end
