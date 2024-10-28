# frozen_string_literal: true

require 'rails_helper'

SWG_DEV = 'dev/swagger.json'

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s

  config.openapi_specs = {
    SWG_DEV => {
      openapi: '3.0.1',
      info: {
        title: 'DEV Server API',
        description: 'APIs only for DEV server.'
      }
    },
    'v1/swagger.json' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1',
        description: 'myHomeIQ API'
      },
      paths: {}
    }
  }

  config.openapi_format = :json
  config.openapi_strict_schema_validation = true
end
