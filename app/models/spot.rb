# frozen_string_literal: true

class Spot < ApplicationRecord
  belongs_to :user
  validates :accident_date, presence: true
  validates :accident_type, presence: true
  validates :contents
  validates :longitude, presence: true
  validates :latitude, presence: true

  def owned_by?(target_user)
    user == target_user
  end
end
