# frozen_string_literal: true

class Petitions::List::ListOwnService
  attr_accessor :user, :filter, :page

  def initialize(user:, filter:, page: 1)
    @user = user
    @filter = filter
    @page = page
  end

  def call
    binding.pry

    user.petitions.includes(:user).ransack(search.call).result.page(page.to_i)
  end

  private

  def search
    @search ||= Petitions::Searches::QueryTermService.new(filter: filter)
  end
end
