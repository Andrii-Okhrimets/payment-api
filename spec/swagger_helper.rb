# frozen_string_literal: true

require 'rails_helper'

SWG_PAYMENT = 'payment/swagger.json'

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s

  config.openapi_specs = {
    SWG_PAYMENT => {
      openapi: '3.0.1',
      info: {
        title: 'DEV Server API',
        description: 'APIs only for DEV server.'
      }
    }
  }

  config.openapi_format = :json
  config.openapi_strict_schema_validation = true
end
