class Appliance < ApplicationRecord
  belongs_to :user
  belongs_to :smart_home_system
  has_many :consumption_entries, as: :consumption
end
