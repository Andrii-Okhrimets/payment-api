require 'rails_helper'

RSpec.describe Subscription do
  describe 'Enums' do
    let(:statuses) { %w[pending insufficient_funds failed success] }

    it { is_expected.to define_enum_for(:status).with_values(statuses) }
  end

  describe '#balance_in_dollars' do
    let(:subscription) { create(:subscription, balance: balance) }

    context 'when balance is 10000 cents' do
      let(:balance) { 10_000 }

      it 'returns the balance in dollars' do
        expect(subscription.balance_in_dollars).to eq('100.00')
      end
    end

    context 'when balance is 12345 cents' do
      let(:balance) { 12_345 }

      it 'returns the balance in dollars' do
        expect(subscription.balance_in_dollars).to eq('123.45')
      end
    end
  end

  describe '#remaining_amount_in_dollars' do
    let(:subscription) { create(:subscription, remaining_amount: remaining_amount) }

    context 'when remaining amount is 5000 cents' do
      let(:remaining_amount) { 5000 }

      it 'returns the remaining amount in dollars' do
        expect(subscription.remaining_amount_in_dollars).to eq('50.00')
      end
    end

    context 'when remaining amount is 6789 cents' do
      let(:remaining_amount) { 6789 }

      it 'returns the remaining amount in dollars' do
        expect(subscription.remaining_amount_in_dollars).to eq('67.89')
      end
    end
  end
end
