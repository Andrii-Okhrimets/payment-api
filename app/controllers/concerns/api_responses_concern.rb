module ApiResponsesConcern
  extend ActiveSupport::Concern

  private

  # Render 422 error: Validations failed
  def response_invalid(errors, status: 422)
    if errors.is_a?(Array)
      render(json: format_system_errors(errors), status:)
    else
      render json: errors, status:, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  # Render 404 error: Not found
  def response_not_found(exception)
    Notifier.info(exception.message, backtrace: exception.backtrace.join("\n")) if Rails.env.dev?
    render json: format_system_errors(['Not found.']), status: :not_found
  end

  # Render 403 error: Forbidden access
  def response_forbidden
    render json: format_system_errors(['You do not have access to do this.']), status: :forbidden
  end

  def format_system_errors(errors)
    { errors: errors.map { |error_text| { source: { pointer: '' }, detail: error_text } } }
  end
end
