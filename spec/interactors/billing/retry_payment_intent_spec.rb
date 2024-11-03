require 'rails_helper'

describe Billing::RetryPaymentIntent do
  subject(:interactor) { described_class.call(subscription:) }

  let(:subscription) { create(:subscription, balance:, remaining_amount:) }

  describe '#call' do
    context 'when the remaining amount is less than the balance' do
      let(:balance) { 10_000 }
      let(:remaining_amount) { 5000 }

      it 'updates the subscription with the new balance and sets status to success' do
        interactor

        expect(subscription.reload).to have_attributes(balance: 5000, remaining_amount: 0,
                                                       status: 'success')
      end
    end

    context 'when the remaining amount is greater than the balance' do
      let(:balance) { 3000 }
      let(:remaining_amount) { 5000 }

      it 'marks the subscription as failed' do
        interactor

        expect(subscription.reload).to have_attributes(balance: 3000, remaining_amount: 5000,
                                                       status: 'failed')
      end
    end
  end
end
