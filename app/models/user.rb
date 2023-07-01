class User < ApplicationRecord
  has_many :spot, dependent: :destroy
end
