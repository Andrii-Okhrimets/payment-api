module Billing
  class PaymentIntent
    include Interactor

    REDUCTION_RATES = [1.0, 0.75, 0.5, 0.25].freeze

    delegate :subscription, :amount, to: :context

    def call
      context.amount = (amount * 100).round(2)

      REDUCTION_RATES.each_with_index do |multiplier, attempt|
        amount_to_charge = (multiplier * amount).round(2)

        if sufficient_funds?(amount_to_charge)
          process_charge(amount_to_charge, attempt)
          return
        end
      end

      process_failed
    rescue StandardError
      error = 'Unable to create a mayment intent'
      # Notifier.error error, error: e.message, backtrace: e.backtrace  # Notifier is not defined
      context.fail!(error: error)
    end

    private

    def sufficient_funds?(amount_to_charge)
      subscription.balance >= amount_to_charge
    end

    def process_charge(amount_to_charge, attempt)
      if attempt.zero?
        subscription.update!(status: :success, balance: subscription.balance - amount_to_charge,
                             retry_attempts: attempt + 1, remaining_amount: 0)
      else
        remaining_amount = amount - amount_to_charge
        subscription.update!(status: :insufficient_funds,
                             balance: subscription.balance - amount_to_charge,
                             next_pay_at: 1.week.from_now, retry_attempts: attempt + 1,
                             remaining_amount: remaining_amount)
      end
    end

    def process_failed
      subscription.update!(status: :failed, retry_attempts: REDUCTION_RATES.size,
                           remaining_amount: amount)
    end
  end
end
