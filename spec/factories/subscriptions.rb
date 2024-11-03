# == Schema Information
#
# Table name: subscriptions
#
#  id               :bigint           not null, primary key
#  balance          :decimal(36, 18)
#  next_pay_at      :date
#  remaining_amount :decimal(36, 18)
#  retry_attempts   :integer          default(0), not null
#  status           :integer          default("pending"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :subscription do
    balance { 1000 }
    remaining_amount { 0 }
    status { :pending }
    retry_attempts { 0 }
    next_pay_at { 1.week.from_now }

    trait(:pending) { status { :pending } }
    trait(:insufficient_funds) { status { :insufficient_funds } }
    trait(:failed) { status { :failed } }
    trait(:success) { status { :success } }
  end
end
