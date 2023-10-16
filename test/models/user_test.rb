# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "admin?" do
    assert users(:watanabe).admin?
    assert_not users(:test01).admin?
  end

  test "member_scope" do
    assert_equal users(:test01), User.all.member[0]
  end

  test "create uniqe id" do
    assert_equal 36, User.create_unique_string.length
  end
end
