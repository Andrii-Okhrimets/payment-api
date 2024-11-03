require 'rails_helper'

describe Billing::PaymentIntent do
  subject(:interactor) { described_class.call(subscription:, amount:) }

  let(:subscription) { create(:subscription, :pending, balance: 15_000) }

  let(:now) { Time.zone.local(2024, 11, 3, 20, 22) }

  describe '#call' do
    before { travel_to(now) }

    context 'when payment is successful' do
      let(:amount) { 100 }

      it 'resets retry attempts and processes the charge' do
        interactor

        expect(subscription.reload).to have_attributes(status: 'success', balance: 5000,
                                                       retry_attempts: 1, remaining_amount: 0)
      end
    end

    context 'when payment is insufficient funds' do
      let(:amount) { 250 }

      it 'attempts to charge 75%, 50%, and 25% of the amount' do
        interactor

        expect(subscription.reload).to have_attributes(status: 'insufficient_funds', balance: 2500,
                                                       retry_attempts: 3, remaining_amount: 12_500,
                                                       next_pay_at: 1.week.after(now).to_date)
      end
    end

    context 'when payment fails for all attempts' do
      let(:amount) { 1000 }

      it 'marks the subscription as failed' do
        interactor

        expect(subscription.reload).to have_attributes(status: 'failed', balance: 15_000,
                                                       retry_attempts: 4, remaining_amount: 100_000)
      end
    end
  end
end
