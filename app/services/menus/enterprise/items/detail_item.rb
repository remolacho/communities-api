# frozen_string_literal: true

class Menus::Enterprise::Items::DetailItem
  attr_accessor :user, :can_show

  def initialize(user:, can_show:)
    @user = user
    @can_show = can_show
  end

  def perform
    {
      detail: {
        code: 'detail',
        show: can_show
      }
    }
  end
end
