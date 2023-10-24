require 'application_system_test_case'

class AuthorizationIntegrationTest < ApplicationSystemTestCase
  setup do
    OmniAuth.config.test_mode = true
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth']  = google_oauth2_mock
  end

  teardown do
    OmniAuth.config.test_mode = false
  end

  test 'authorizes and sets user currently in database with Google OAuth' do
    visit user_session_path
    assert page.has_content? 'GOOGLEアカウントでログイン'
    click_on 'Googleアカウントでログイン'
    assert_selector '#flash', text: 'Google アカウントによる認証に成功しました。'
  end

  private

  def google_oauth2_mock
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
end
