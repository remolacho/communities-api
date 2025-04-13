# frozen_string_literal: true

class StatusesPetitions::List::AllowedCodesService < StatusesPetitions::List::FacadeService
  def code
    generate_codes
  end

  def exists?(code)
    generate_codes.include?(code)
  end

  private

  def generate_codes
    @generate_codes ||= factory.call.map { |s| s[:code] }
  end
end
