# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'adminかどうか' do
    admin_user = FactoryBot.create(:user, :admin_user)
    expect(admin_user).to be_admin
  end

  it '36桁のユニークIDが生成できているかどうか' do
    expect(described_class.create_unique_string.length).to eq 36
  end
end
