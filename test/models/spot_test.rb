# frozen_string_literal: true

require 'test_helper'

class SpotTest < ActiveSupport::TestCase
  test 'spot owned by?' do
    assert spots(:spot1).owned_by?(users(:watanabe))
    assert_not spots(:spot1).owned_by?(users(:test01))
  end
end
