# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersPetitions::DeleteService do
  include_context 'delete_answer_petition_stuff'

  context 'when you want delete 1 answer to PQR' do
    it 'error the user cannot delete because status is resolve' do
      current_answer = answer
      current_petition = current_answer.petition
      current_petition.status_id = Status.petition_resolve.id
      current_petition.save!

      service = described_class.new(answer: current_answer, user: user)
      expect { service.call }.to raise_error(PolicyException)
    end

    it 'success and create follow petition for answer delete' do
      described_class.new(answer: answer, user: user).call

      expect(answer.petition.follow_petitions.where(status_id: Status.answer_deleted.id)).to be_present
    end
  end
end
