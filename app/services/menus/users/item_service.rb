# frozen_string_literal: true

class Menus::Users::ItemService
  attr_accessor :user

  def initialize(user:)
    @user = user
  end

  def perform
    {
      users: {
        code: 'users',
        show: true,
        items: items
      }
    }
  end

  private

  def items
    {}.merge!(profile_item.perform)
      .merge!(list_item.perform)
      .merge!(assign_roles.perform)
      .merge!(remove_roles.perform)
  end

  def profile_item
    ::Menus::Users::Items::ProfileItem.new(user: user)
  end

  def list_item
    ::Menus::Users::Items::ListItem.new(user: user)
  end

  def assign_roles
    ::Menus::Users::Items::AssignRolesItem.new(user: user)
  end

  def remove_roles
    ::Menus::Users::Items::RemoveRolesItem.new(user: user)
  end
end
