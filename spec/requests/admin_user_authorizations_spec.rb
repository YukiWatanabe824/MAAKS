require 'rails_helper'

RSpec.describe "AdminUserAuthorizations", type: :request do
  describe "GET /admin_user_authorizations" do
    it "works! (now write some real specs)" do
      get admin_user_authorizations_path
      expect(response).to have_http_status(200)
    end
  end
end
