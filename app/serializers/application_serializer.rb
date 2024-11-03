class ApplicationSerializer < ActiveModel::Serializer
  def id
    object.to_param
  end

  private

  def decorated_object
    @decorated_object ||= object.decorate
  end

  def current_user
    @current_user ||= instance_options[:current_user]
  end
end
