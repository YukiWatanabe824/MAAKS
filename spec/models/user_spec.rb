require 'rails_helper'

RSpec.describe User, type: :model do
  it 'adminかどうか' do
    admin_user = User.new(name: '', email: '', encrypted_password: '', admin: true)
    not_admin_user = User.new(name: '', email: '', encrypted_password: '')

    expect(admin_user.admin?).to be_truthy
    expect(not_admin_user.admin?).to be_falsey
  end

  it '36桁のユニークIDが生成できているかどうか' do
    expect(User.create_unique_string.length).to eq 36
  end
end
