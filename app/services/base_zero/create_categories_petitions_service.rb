# frozen_string_literal: true

module BaseZero
  class CreateCategoriesPetitionsService
    def initialize(enterprise)
      @enterprise = enterprise
    end

    def create
      return false unless @enterprise

      Shared::CategoriesPetitionsList.all.each do |category|
        CategoryPetition.find_or_create_by!(
          name: category[:name],
          slug: category[:name].parameterize,
          enterprise_id: @enterprise.id
        )
      end
    rescue StandardError => e
      Rails.logger.error("Error creating categories: #{e.message}")
    end
  end
end
