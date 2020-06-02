class SmartHomeSystem < ApplicationRecord
  def self.type_array
    ["Google Home", "Alexa", "Smart Plug", "Apple Home Kit", "Other"]
  end

  belongs_to :user
  has_many :appliances

  validates :name, presence: true
  validates :type, presence: true, inclusion: {in: type_array}
  validates :username, presence: true
  validates :password, presence: true
end
