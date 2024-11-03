class RetryPaymentIntentJob < ApplicationJob
  def perform
    Subscription.insufficient_funds.where(next_pay_at: ..7.days.ago).find_each do |subscription|
      Billing::RetryPaymentIntent.call(subscription: subscription)
    end
  end
end
