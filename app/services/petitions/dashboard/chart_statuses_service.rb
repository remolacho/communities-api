# frozen_string_literal: true

class Petitions::Dashboard::ChartStatusesService
  attr_accessor :user, :statuses

  def initialize(user:, statuses:)
    @user = user
    @statuses = statuses
  end

  def call
    percentage
  end

  private

  def percentage
    statuses.map do |status|
      count = counters[status.id]
      next hash_percentage(status) unless count.present?

      hash_percentage(status).merge(percentage: calc_percentage(count), counter: count)
    end
  end

  def hash_percentage(status)
    {
      id: status.id,
      code: status.code,
      name: status.as_name,
      color: status.color,
      percentage: 0,
      counter: 0,
      total: total_records,
      symbol: '%'
    }
  end

  def calc_percentage(count)
    ((count * 100).to_f / total_records.to_f).round(2)
  end

  def total_records
    @total_records ||= counters.values.sum
  end

  def counters
    @counters ||= Petition.group(:status_id).count(:id)
  end
end
