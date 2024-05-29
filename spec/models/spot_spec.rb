# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spot, type: :model do
  it 'spotの所有者が.owned_byでわかる' do
    user_owned_spot = User.new(name: '', email: '', encrypted_password: '')
    spot = user_owned_spot.spots.new(title: '西新井での単独落車事故',
                                     accident_type: '自損',
                                     contents: '走行中に左折レーンに入ってしまい直進しようとした際に、後方車列を振り向いて確認した際にふらついて落車',
                                     accident_date: '2014-01-01 00:00:01',
                                     longitude: 139.774373,
                                     latitude: 35.684420,
                                     created_at: '2014-01-01 00:00:01',
                                     updated_at: '2014-01-01 00:00:01')
    user_not_owned_spot = User.new(name: '', email: '', encrypted_password: '')
    expect(spot.owned_by?(user_owned_spot)).to be_truthy
    expect(spot.owned_by?(user_not_owned_spot)).to be_falsey
  end
end
