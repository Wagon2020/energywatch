class EnergyProvider < ApplicationRecord
  has_many :utility_accounts

  validates :name, presence: true
  validates :url, presence: true
end
