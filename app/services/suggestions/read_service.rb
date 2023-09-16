# frozen_string_literal: true

class Suggestions::ReadService
  attr_accessor :user, :suggestion
  def initialize(user:, suggestion:)
    @user = user
    @suggestion = suggestion
  end

  def call
    suggestion.update(read: can_change_to_read?)
    suggestion.reload
  end

  private

  def can_change_to_read?
    user.id != suggestion.user_id
  end
end
