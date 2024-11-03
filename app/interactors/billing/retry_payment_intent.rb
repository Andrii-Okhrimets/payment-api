module Billing
  class RetryPaymentIntent
    include Interactor

    delegate :subscription, to: :context

    def call
      amount = subscription.balance - subscription.remaining_amount

      return subscription.failed! if amount.negative?

      subscription.update!(balance: amount, remaining_amount: 0, status: :success)
    end
  end
end
