# frozen_string_literal: true

class Suggestions::ReadService
  attr_accessor :user, :suggestion
  def initialize(user:, suggestion:)
    @user = user
    @suggestion = suggestion
  end

  def call
    suggestion.update(read: true)
    suggestion.reload
  end
end
