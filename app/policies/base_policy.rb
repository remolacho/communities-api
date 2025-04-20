# frozen_string_literal: true

class BasePolicy
  attr_accessor :current_user

  def initialize(current_user:)
    @current_user = current_user
  end

  def loudly
    raise(ArgumentError) unless block_given?
    return true if yield

    raise(PolicyException, I18n.t('policies.exceptions.unauthorized'))
  end

  private

  def entity
    raise(NotImplementedError, I18n.t('policies.exceptions.not_implemented'))
  end

  def role?(permission)
    user_roles_ids.present? && find_can_permission?(permission)
  end

  def find_can_permission?(permission)
    @find_can_permission ||= entity_permission.find_by(permission => true).present?
  end

  def entity_permission
    @entity_permission ||= EntityPermission.for_entity_type(entity).for_role(user_roles_ids)
  end

  def user_roles_ids
    @user_roles_ids ||= current_user.roles.ids
  end
end
