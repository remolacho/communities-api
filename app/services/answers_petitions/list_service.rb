# frozen_string_literal: true

module AnswersPetitions
  class ListService
    attr_accessor :user, :petition

    def initialize(user:, petition:)
      @user = user
      @petition = petition
    end

    def call
      ActiveModelSerializers::SerializableResource.new(answers,
                                                       each_serializer: ::AnswersPetitions::DetailSerializer,
                                                       enterprise_subdomain: user.enterprise.subdomain,
                                                       current_user: user)
    end

    private

    def answers
      @answers ||= petition.answers_petitions.includes(:user, :petition).order(created_at: :asc)
    end
  end
end
