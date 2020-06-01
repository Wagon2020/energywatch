class Appliance < ApplicationRecord
  belongs_to :user
  belongs_to :smart_home_system
end
