module V1
  module Subscriptions
    class SubscriptionSerializer < ApplicationSerializer
      attributes :id, :balance_in_dollars, :remaining_amount_in_dollars, :status, :retry_attempts, 
                 :next_pay_at
    end
  end
end
