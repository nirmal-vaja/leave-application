class Holiday < ApplicationRecord
  validates :date, presence: true
  validates :occasion, presence: true
end
