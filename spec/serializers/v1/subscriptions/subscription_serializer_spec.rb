require 'rails_helper'

describe V1::Subscriptions::SubscriptionSerializer do
  subject(:staff_json) { described_class.new(subscription).to_json }

  let(:subscription) do
    create(:subscription, :pending, balance: 200, remaining_amount: 300, retry_attempts: 2,
                                    next_pay_at: 1.week.from_now)
  end

  let(:expected_attrs) do
    {
      id: subscription.id.to_s,
      balance_in_dollars: '2.00',
      remaining_amount_in_dollars: '3.00',
      status: 'pending',
      retry_attempts: 2,
      next_pay_at: 1.week.from_now.to_date
    }
  end

  it 'has a correct values' do
    expect(parse_json(staff_json)).to eq expected_attrs.as_json
  end
end
