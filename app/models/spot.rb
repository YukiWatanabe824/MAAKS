class Spot < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :accident_date, presence: true
  validates :accident_type, presence: true
  validates :contents, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
end
