# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminUserAuthorizations', type: :request do
  let(:regular_user) { FactoryBot.create(:user, :not_admin_user) }
  let(:other_user) { FactoryBot.create(:user, :admin_user) }
  let(:spot) { FactoryBot.create(:spot, :make_by_standard_user) }

  describe 'GET edit_admins_user_path' do
    it 'regular user cant access to editer for admin' do
      sign_in regular_user
      get edit_admins_user_path(regular_user)
      expect(response).to have_http_status :not_found
    end
  end

  describe 'DELETE admins_user_path' do
    it 'regular user cant delete other user' do
      sign_in regular_user
      delete admins_user_path(other_user)
      expect(response).to have_http_status :not_found
    end
  end

  describe 'PUT admins_user_path' do
    it 'regular user cant edit myself by admins path' do
      sign_in regular_user
      put admins_user_path(regular_user)
      expect(response).to have_http_status :not_found
    end
  end

  describe 'PUT admins_spot_path' do
    it 'regular user cant edit myspot by admins path' do
      sign_in regular_user
      put admins_spot_path(spot)
      expect(response).to have_http_status :not_found
    end
  end

  describe 'DELETE admins_spot_path' do
    it 'regular user cant delete myspot by admins pass' do
      sign_in regular_user
      delete admins_spot_path(spot)
      expect(response).to have_http_status :not_found
    end
  end
end
