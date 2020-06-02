class ConsumptionEntry < ApplicationRecord
  belongs_to :consumption, polymorphic: true
end
