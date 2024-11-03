# frozen_string_literal: true

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
class Subscription < ApplicationRecord
  enum :status, { pending: 0, insufficient_funds: 1, failed: 2, success: 3 }

  def balance_in_dollars
    format('%.2f', (balance.to_d / 100))
  end

  def remaining_amount_in_dollars
    format('%.2f', (remaining_amount.to_d / 100))
  end
end
