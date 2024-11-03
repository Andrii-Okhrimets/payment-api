require 'rails_helper'

RSpec.describe RetryPaymentIntentJob do
  include ActiveJob::TestHelper

  let!(:subscription1) { create(:subscription, :insufficient_funds, next_pay_at: 8.days.ago) }
  let!(:subscription2) { create(:subscription, :insufficient_funds, next_pay_at: 6.days.ago) }
  let!(:subscription3) { create(:subscription, :insufficient_funds, next_pay_at: 10.days.ago) }
  let!(:subscription4) { create(:subscription, :success, next_pay_at: 8.days.ago) }

  before do
    allow(Billing::RetryPaymentIntent).to receive(:call)
  end

  describe '#perform' do
    it 'calls RetryPaymentIntent for subscriptions with insufficient funds and next_pay_at older than 7 days' do
      described_class.perform_now

      expect(Billing::RetryPaymentIntent).to have_received(:call).with(subscription: subscription1)
      expect(Billing::RetryPaymentIntent).to have_received(:call).with(subscription: subscription3)
      expect(Billing::RetryPaymentIntent).not_to have_received(:call).with(subscription: subscription2)
      expect(Billing::RetryPaymentIntent).not_to have_received(:call).with(subscription: subscription4)
    end
  end
end
