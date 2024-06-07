# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminUserAuthorizations', type: :request do
  describe 'GET edit_admins_user_path' do
    it 'regular user is denied access' do
      user = FactoryBot.create(:user, :not_admin_user)
      sign_in user

      get edit_admins_user_path(user)
      expect(response).to have_http_status '404'
    end
  end
end
