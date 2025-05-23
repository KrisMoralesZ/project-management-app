class Plan < ApplicationRecord
  PLANS = [ :free, :premium ]

  def self.options
    PLANS.map { |plan| [ plan.capitalize, plan ] }
  end
end
