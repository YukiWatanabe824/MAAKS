# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spot, type: :model do
  it 'spotの所有者が.owned_byでわかる' do
    spot = FactoryBot.create(:spot, :make_by_admin_user)
    user_not_owned_spot = FactoryBot.create(:user, :not_admin_user)
    expect(spot.owned_by?(spot.user)).to be_truthy
    expect(spot.owned_by?(user_not_owned_spot)).to be_falsey
  end
end
