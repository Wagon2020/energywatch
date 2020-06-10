class EnergyProvider < ApplicationRecord
  has_many :utility_accounts

  validates :name, presence: true
  validates :name, uniqueness: true, case_sensitive: false
  validates :url, presence: true
end
