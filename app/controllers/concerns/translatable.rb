# rubocop:disable all
# frozen_string_literal: true
#
module Translatable
  # Set current user language to I18n
  def set_language
    I18n.locale = language
  end

  # Get current user language
  def language
    params[:lang].presence.to_sym || current_user&.lang.presence.to_sym || :es
  end
end
