module Carts
  class CleanupJob < ApplicationJob
    queue_as :default

    def perform
      mark_abandoned_carts
      remove_old_abandoned_carts
    end

    private

    def mark_abandoned_carts
      Cart.inactive_for_3_hours.find_each do |cart|
        cart.mark_as_abandoned!
      end
    end

    def remove_old_abandoned_carts
      Cart.abandoned_for_7_days.find_each(&:destroy!)
    end

  end
end