# frozen_string_literal: true

require 'test_helper'

class SpotTest < ActiveSupport::TestCase
  test 'spot owned by?' do
    assert spots(:one).owned_by?(users(:watanabe))
    assert_not spots(:one).owned_by?(users(:otameshisan))
  end
end
