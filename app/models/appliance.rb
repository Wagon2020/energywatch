class Appliance < ApplicationRecord
  def self.energy_performance_array
    ["A+++", "A++", "A+", "A", "B", "C", "D"]
  end

  belongs_to :user
  belongs_to :smart_home_system, optional: true
  has_many :consumption_entries, as: :consumption

  validates :appliance_type, presence: true
  validates :energy_performance, presence: true
  validates :user_id, numericality: true
end
