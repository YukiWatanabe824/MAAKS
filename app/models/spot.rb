# frozen_string_literal: true

class Spot < ApplicationRecord
  belongs_to :user
  validates :accident_date, :accident_type, :longitude, :latitude, presence: true

  def owned_by?(target_user)
    user == target_user
  end
end
