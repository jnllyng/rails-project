class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  belongs_to :province

  validates :status, presence: true
  validates :total, numericality: { greater_than_or_equal_to: 0 }
end
