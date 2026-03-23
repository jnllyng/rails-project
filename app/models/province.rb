class Province < ApplicationRecord
  has_many :addresses
  has_many :orders

  validates :name, presence: true, uniqueness: true
  validates :gst, numericality: { greater_than_or_equal_to: 0 }
  validates :pst, numericality: { greater_than_or_equal_to: 0 }
  validates :hst, numericality: { greater_than_or_equal_to: 0 }
end
