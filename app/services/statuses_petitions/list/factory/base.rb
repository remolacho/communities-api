# frozen_string_literal: true

class StatusesPetitions::List::Factory::Base
  attr_accessor :user, :petition

  def initialize(user:, petition:)
    @user = user
    @petition = petition
  end

  def call
    return [] unless can_view?

    serializer
  end

  private

  def serializer
    ActiveModelSerializers::SerializableResource.new(statuses,
                                                     each_serializer: ::Statuses::DetailSerializer).as_json
  end

  def statuses
    raise NotImplementedError
  end

  def can_view?
    raise NotImplementedError
  end
end
