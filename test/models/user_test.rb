# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'admin?' do
    assert users(:watanabe).admin?
    assert_not users(:otameshisan).admin?
  end

  test 'create uniqe id' do
    assert_equal 36, User.create_unique_string.length
  end
end
