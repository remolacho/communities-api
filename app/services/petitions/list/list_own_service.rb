# frozen_string_literal: true

class Petitions::List::ListOwnService
  attr_accessor :user, :filter, :page

  def initialize(user:, filter:, page: 1)
    @user = user
    @filter = filter
    @page = page
  end

  def call
    user.petitions
      .includes(:user, :status, :category_petition)
      .ransack(filter.call)
      .result
      .order(updated_at: :desc)
      .page(page.to_i)
  end
end
