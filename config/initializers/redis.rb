# frozen_string_literal: true

REDIS = if Rails.env.test?
          MockRedis.new
        else
          Redis.new(url: ENV['REDIS_URL'])
        end
