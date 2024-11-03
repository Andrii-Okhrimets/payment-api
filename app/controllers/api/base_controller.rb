# frozen_string_literal: true

module Api
  class BaseController < ActionController::API
    include ApiResponsesConcern
    include Pundit

    rescue_from ActiveRecord::RecordNotFound, with: :response_not_found
    rescue_from Pundit::NotAuthorizedError, with: :response_forbidden

    private

    # Patch private PagerApi::Pagination::Kaminari.meta method to keep meta data for pagination
    def meta(collection, options = {})
      super.merge(options[:meta] || {})
    end
  end
end
