class SmartHomeSystem < ApplicationRecord
  belongs_to :user
  has_many :appliances
end
