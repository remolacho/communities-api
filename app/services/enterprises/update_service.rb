# frozen_string_literal: true

class Enterprises::UpdateService
  attr_accessor :user, :enterprise, :data
  def initialize(user:, enterprise:, data:)
    @user = user
    @enterprise = enterprise
    @data = data.to_h.deep_symbolize_keys
  end

  def call
    raise ArgumentError, I18n.t("services.enterprises.update.data_empty") unless data.present?

    rejected_attrs

    ActiveRecord::Base.transaction do
      record = enterprise.update!(allowed_data)
      enterprise.logo.attach(data[:logo]) if data[:logo].present?
      enterprise.banner.attach(data[:banner]) if data[:banner].present?
      record
    end
  end

  private

  def rejected_attrs
    raise ArgumentError, I18n.t("services.enterprises.update.attribute.not_allowed", attr: :id) if data.key?(:id)
    raise ArgumentError, I18n.t("services.enterprises.update.attribute.not_allowed", attr: :token) if data.key?(:token)
    raise ArgumentError, I18n.t("services.enterprises.update.attribute.not_allowed", attr: :active) if data.key?(:active)
    raise ArgumentError, I18n.t("services.enterprises.update.attribute.not_allowed", attr: :reference_regex) if data.key?(:reference_regex)
    raise ArgumentError, I18n.t("services.enterprises.update.attribute.not_allowed", attr: :short_name) if data.key?(:short_name)
    raise ArgumentError, I18n.t("services.enterprises.update.attribute.not_allowed", attr: :subdomain) if data.key?(:subdomain)
  end

  def allowed_data
    params = define_logo(data)
    define_banner(params)
  end

  def define_logo(params)
    params.reject{ |k, _| k == :logo }
  end

  def define_banner(params)
    params.reject{ |k, _| k == :banner }
  end
end
