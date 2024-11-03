require 'rails_helper'

module JobsHelpers
  def job_now
    perform_enqueued_jobs { job }
  end

  def job_now_with_error_catcher
    job
    perform_enqueued_jobs
  end
end

RSpec.configure do |c|
  c.include JobsHelpers
end
