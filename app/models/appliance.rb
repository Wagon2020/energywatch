class Appliance < ApplicationRecord
  belongs_to :user
  belongs_to :smart_home_system, optional: true
  has_many :consumption_entries, as: :consumption

  validates :type, presence: true
  validates :energy_performance, presence: true
  validates :user_id, numericality: true
end
