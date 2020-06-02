class UtilityAccount < ApplicationRecord
  belongs_to :energy_provider
  has_one :user
  has_many :consumption_entries, as: :consumption

  validates :username, presence: true
  validates :password, presence: true
  validates :email, presence: true
  validates :meter_ref, presence: true
end
