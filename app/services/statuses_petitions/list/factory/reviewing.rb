# frozen_string_literal: true

class StatusesPetitions::List::Factory::Reviewing < StatusesPetitions::List::Factory::Base

  private

  def serializer
    ActiveModelSerializers::SerializableResource.new(statuses,
                                                     each_serializer: ::Statuses::DetailSerializer).as_json
  end

  # override
  def statuses
    [
      Status.petition_pending,
      Status.petition_confirm
    ]
  end

  # override
  def can_view?
    (petition.roles.ids & user.roles.ids).any?
  end
end
