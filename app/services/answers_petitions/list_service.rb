# frozen_string_literal: true

class AnswersPetitions::ListService

  attr_accessor :user, :petition

  def initialize(user:, petition:)
    @user = user
    @petition = petition
  end

  def call
    ActiveModelSerializers::SerializableResource.new(answers,
                                                     each_serializer: ::AnswersPetitions::DetailSerializer)
  end

  private
  def answers
    @answers ||= petition.answers_petitions.includes(:user).order(id: :desc)
  end
end