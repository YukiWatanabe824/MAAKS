# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spot, type: :model do
  it 'spotの所有者が.owned_byでわかる' do
    spot = FactoryBot.create(:spot, :make_by_admin_user)
    expect(spot).to be_owned_by(spot.user)
  end
end
