# rubocop:disable all
# frozen_string_literal: true

module Translatable
  extend ActiveSupport::Concern

  included do
    before_action :set_language
  end

  # Set current user language to I18n
  def set_language
    I18n.locale = language.to_sym
  end

  # Get current user language
  def language
    params[:lang].presence || current_user&.lang.presence || :es
  end
end
