# frozen_string_literal: true

class Menus::Suggestions::ItemService
  attr_accessor :user

  def initialize(user:)
    @user = user
  end

  def perform
    {
      suggestions: {
        code: 'suggestions',
        show: true,
        items: items
      }
    }
  end

  private

  def items
    {}.merge!(create_item.perform)
      .merge!(self_list.perform)
      .merge!(list_item.perform)
  end

  def create_item
    ::Menus::Suggestions::Items::CreateItem.new(user: user)
  end

  def self_list
    ::Menus::Suggestions::Items::SelfListItem.new(user: user)
  end

  def list_item
    ::Menus::Suggestions::Items::ListItem.new(user: user)
  end
end
