class UtilityAccount < ApplicationRecord
  belongs_to :energy_provider
  has_one :user
  has_many :consumption_entries, as: :consumption
end
