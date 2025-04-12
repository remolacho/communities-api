# frozen_string_literal: true

class Menus::Enterprise::ItemService < Enterprises::Profile::Policy
  def initialize(user:)
    super(current_user: user)
  end

  def perform
    {
      enterprise: {
        code: 'enterprise',
        show: can_show?,
        items: items
      }
    }
  end

  private

  def items
    {}.merge!(detail_item.perform)
      .merge!(edit_item.perform)
  end

  def detail_item
    ::Menus::Enterprise::Items::DetailItem.new(user: current_user, can_show: can_show?)
  end

  def edit_item
    ::Menus::Enterprise::Items::EditItem.new(user: current_user)
  end

  def can_show?
    @can_show ||= has_role?
  end
end
