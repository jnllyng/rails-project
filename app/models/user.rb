class User < ApplicationRecord
  has_many :addresses
  has_many :orders

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
end
