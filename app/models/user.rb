# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]
  has_many :spot, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { uid.present? }
  validates :admin, inclusion: [true, false]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  scope :member, -> { where(admin: false) }
end
