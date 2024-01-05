# frozen_string_literal: true

require 'test_helper'

class AdminUserAuthorizationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'regular user is denied access to admin' do
    user = users(:otameshisan)
    other = users(:watanabe)

    sign_in user
    get edit_admins_user_path(user)
    assert_equal 404, status

    sign_in user
    delete admins_user_path(other)
    assert_equal 404, status

    sign_in user
    put admins_user_path(user)
    assert_equal 404, status

    spot = spots(:one)
    sign_in user
    put admins_spot_path(spot)
    assert_equal 404, status

    sign_in user
    delete admins_spot_path(spot)
    assert_equal 404, status
  end
end
