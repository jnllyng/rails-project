class Province < ApplicationRecord
  has_many :addresses
  has_many :orders
end
